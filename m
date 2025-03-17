Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A50C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGKA-0003lO-Hj; Mon, 17 Mar 2025 15:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGK8-0003l4-Bx
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:40:32 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGK6-0002sC-MN
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:40:32 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6e8f254b875so45192456d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742240429; x=1742845229; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PvB8wd1obLSWt4OF2243ZvenRMD6O0V440HtBPk9Iz8=;
 b=WK+IBdu3bezInbOcniT/DvdAyYEZTWD8XY//xXDPfMdJ28+hMpDaDh2iHbqDfUTOB0
 V/NAOtyZDCASieP67W4BG2NaEKDrv/tmolZx6LovK7fUv0GWHp8rmVHI+sqH26tNgK/a
 R/FCx+fqR22nJwy8oWS649TWZqp4ZQ4oivWJ58ei9FLWqUkb6d5CBZQAVoO6Ww6Fh242
 XiPTV1kdrYK3O/e2Q5wxFLfmegaQcc4Fgmvva77mh97vTJELu8FGQl4mXqx5US0XZh0P
 bPbYhOeLeeXpqd/HjtTBCv4n1UmqADTllShQTPkIPq354/xo+yIUWHCYkJ6QhOl/tvUB
 y44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742240429; x=1742845229;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PvB8wd1obLSWt4OF2243ZvenRMD6O0V440HtBPk9Iz8=;
 b=IPYttRCBtCaWDIvLLKzEAqh7Eqco372c5Ekd63ajWBNaUWwZ/3Sj4icPPt3CML8LBj
 SrvrNjIQYrzKUQ0kWdTMhyzxH0tskeJ0G3M2CF7OvB/9sgl0FA0G1OFb2425nfHRL2mG
 so7X5UMJhzS+QLZfYHkjE6+ofVQ+SFggjmQvX3YF0PE5upG+R3EMEmB+eyUaAI6rMuzR
 0mDUV6iBCsdkkXuIdhPdcZAxukWLdBi8IqOUBdV0TGmIhOlejs0aRjuI5wPQ5E0B+1kY
 mg4O34rTwgpbbihEYjAd/uvqfGZwnfkSECCqgPSKyIsjva6e82xwnk8aarlMXThJSIrd
 0Dfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWejTlc2G24Kbv38GEQ6ZD9LDD59KxAsjtwWkoZrCOCF8cQa7bY04JxBsFcOv4WKchFi9LmWlBEP+yI@nongnu.org
X-Gm-Message-State: AOJu0Yy2pczZ9aUuLFMsRNfqpOzWezD8nTFpvv4ms35jzqXG9i2WGNn6
 mvQK0O3ARjHTJW4hIVP0R7Bc8h1uRoULarbntpGHiMXc9nD/I7u0
X-Gm-Gg: ASbGncsFhu83USvMkICF/dZLLT+jpFHpXtauNJ2AAIvAvsKol6dHVJFjSrGogH7Q673
 cKNraKCA+JvStVvWjCgs9/tUqhXkhPsWyvA35BlUdYcL9dHDBn4j9GSOtp+CKTO0O0gGNCe4mfu
 t9iUTZRyrmetN52l7z4RUNZZHozSybU3J1s5glu3gH32K7I/o5KNc9aS8NT2V4NMmn0LEvHv1NG
 kSlpgc2I5Mastdo+6CeN+kTDJPVC44XVD4Hy/LNcrVJfCYZc/b2jf6b/pPxTN5hwqBuezUmrfTX
 za6HkaScGg4bws4v6C6QlkYs2EoV+JayTXeuW++knoLzb47MyJpvvgrYAZ3OHiE=
X-Google-Smtp-Source: AGHT+IHkXvXGLfgWEYKPviRGLElRfwOgzZSKWYSPQOuozPWh7zvY49fJjrMR7S+tTFNWg1jn+AfXdA==
X-Received: by 2002:a05:6214:2528:b0:6d8:99cf:d2db with SMTP id
 6a1803df08f44-6eb1b92628amr12970516d6.38.1742240429690; 
 Mon, 17 Mar 2025 12:40:29 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade235623sm58735446d6.27.2025.03.17.12.40.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 12:40:29 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-15-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-15-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 14/39] target/hexagon: Add system event, cause codes
Date: Mon, 17 Mar 2025 14:40:27 -0500
Message-ID: <018001db9774$701d4ad0$5057e070$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQGm8+ulsvUK1tA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 14/39] target/hexagon: Add system event, cause codes
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


