Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA84C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnz1-0003Tm-LM; Mon, 24 Mar 2025 16:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twnz0-0003TM-Ix
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:01:14 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twnyz-00016n-5s
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:01:14 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6e1b11859a7so17870556d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742846472; x=1743451272; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UDqone1i9pqSul15TF2a/V8oLXjSwF8RI1NeifkTY+g=;
 b=WVNwst5+wo0mnZebFGWB4o4aCNVyLbvLSMKvSVNTpHzJPKza7Lafq1XgZVGdJ+aDTv
 Vx6v4CI9EV4TkdXyS70fztyfeMbNwEp4+xQ1Ko3o1g5hpO7+c23Aj0Y6DUyzPunxHlgn
 utyRFqtTeHpgvoOBBJNr2PedtvL/V/ijc3M6/zTdbtBLph5jmHf81eoA9cXxk9tM7HHf
 qTqdtxOKXnIDBZhG9cZpRTQr5vbiRdX8tvNOwZpEmtQmCvOWMRxNGh6GSENMt2++LpMp
 g3tE7FWU486fcIsN6UBjzpiIRfRPPL+OIjQfbQm7jTFV/L1Js/h2yvveMEhvH5VZvX4F
 X3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742846472; x=1743451272;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDqone1i9pqSul15TF2a/V8oLXjSwF8RI1NeifkTY+g=;
 b=mZZ1a2MZhtnpZoH4+Ax3WA36Q1iw7zu4I/rKH2BEkwuPC6hApbx2Djk3aaumb/vK8f
 1Z3/FT7pZKb7yo6NTLqReBH8bh+cDsO0bae0+dX4NCVakX+yLHXI5DWF0tKFrZwChWPm
 8mknkrmzc6Nswv4UhRURJc/PLrp1+OYPxma+k6SEO7jFc4Nr0KEtWbwbrKmuOmhY6ts2
 744U+iLHeemQGacgIWgOyk6FxGWwO9U2IJn5XG2CfzwxL3Yz849VUdmwufqkqwTdl4hJ
 14KOXqKTQnas9g2Cm3LP6FXdZWOMo5g2hmMcUcMHDBSPa4ZQX2cUucLh1H61/Wa9/u+b
 qbyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR1bn+NmaHv++ZqVSj0PqZkYNvWSLV5PYBWee8EWZhKa+z4ZcdoeNRryp43JgHkVLPmV6Y+v55WULF@nongnu.org
X-Gm-Message-State: AOJu0YzsCvoxSZu6BC/fVetHzH8/61bfOnGqMr67no4dU0ufA49hsH18
 8dR+NwmjZ2V/YsKeCzAB5bHXAEYEQtDuLYH0GXO8HIN85AGFB5Fpv+2yc/zabJw=
X-Gm-Gg: ASbGncuV1jagyC3HtblAi2CtG0YWWKk1rsYWOoMeQ+ORW2+NJqNVDJ8XgxiFH3bduVA
 4AG6C/eJh6kuhKK6CxzHBhL9Symquxnq7mxVJ5BwkM88sMP80v04G3bky5P4orXaCcL+eojeQl6
 2RwtpKo6OBb6kSSFmwU0l9RmcQlCq3DAr180eUE7E/t/r0pDSFZdxzEXHrHQ7JdD8xzxjPc5Mkk
 4IvPaOR1gGzErrGLuJLUUsMQgLCVPEeJDAWjoXa7Kff3HeOQQKQBLA9rpvsZRsnKZcfjypf/q4T
 8P4+kPkYMXhpOTwIhvJcg94seSEkNqkGsZy/0Su1/z2iElHqpmnZzaG9ub2uuUQ=
X-Google-Smtp-Source: AGHT+IFzKnTZJ81Fxu6/RyyZ92oYNj6hmcDbiBJwz6kP1PDwfYZji2GDxeTKAwX6/11dhi2DgMM+3Q==
X-Received: by 2002:a05:6214:dc9:b0:6e8:fe60:fdeb with SMTP id
 6a1803df08f44-6eb3f2beca7mr241084486d6.17.1742846471626; 
 Mon, 24 Mar 2025 13:01:11 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:319a:7f6b:e6fe:90fa])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3ef1f8dasm47780216d6.39.2025.03.24.13.01.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:01:11 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301172045.1295412-5-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 4/8] hw/hexagon: Add support for cfgbase
Date: Mon, 24 Mar 2025 15:01:10 -0500
Message-ID: <04bf01db9cf7$7d5f62e0$781e28a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQBnRK9gH0BRY5vrCSddsvIJtQ/qNAGrZGPZtl4Hq7A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250324-4, 3/24/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2a.google.com
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
> Sent: Saturday, March 1, 2025 11:21 AM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH 4/8] hw/hexagon: Add support for cfgbase
> 
> From: Sid Manning <sidneym@quicinc.com>
> 
> Signed-off-by: Sid Manning <sidneym@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



