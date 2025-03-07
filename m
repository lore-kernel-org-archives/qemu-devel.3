Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C0AC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeZb-0001pf-Mi; Fri, 07 Mar 2025 15:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqeZX-0001nl-9g
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:45:34 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqeZR-0003NW-LP
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:45:27 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6e8fd49b85eso22854686d6.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741380324; x=1741985124; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AwwmxpCkFtAssLneqfu1oQY//CW0XpM9q0IRa7Jge2Q=;
 b=cCqZbLLRNYdgbJL75o+nCGT5GEitzbJIK+HTrJBcj2MEhdkarse3i/3jI/j+JBB1ro
 P4437rACibrjpomCjZ856EvUnCGVyOxKO6cNPNqDmjorVqhT8++pI9qjAWX30tCtFI/J
 vxNvCJsk2tJPLBcF5euw+gJNeUGAGJmMKtER/mn0VO5GCCgY5bc+UMmWhPd7vAkACJCJ
 3C6jcbU9EDcBbav14WxmjpcDYYODq5zBp9n0jFAMiN9fX4jWOP4G8ifjM9FgHbrNILND
 pQ1aJ9r8OTdh+c9a92ZMBFJ+CzvOyMQFwUbnEctKjmX94yIRlqeI4olYZ041AbFAh1Wo
 8z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741380324; x=1741985124;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AwwmxpCkFtAssLneqfu1oQY//CW0XpM9q0IRa7Jge2Q=;
 b=amHpnGQZd5cslZnIsKeOpvKikD05jEcOoyJGgWqctl6Hjp6dOFWhVtV/eoA1CsBJXv
 Kc2tH8KljcwbjGQOpYOud6xZHx1eabIb+VNrvZPrE1NRBOv7mffOms3bimS76FjEhAc7
 KnI/yspQvM6cOwIJgVIE1GgSsBToZeO3fm+nfDeUTZaS0Oq+lzom9MxDg6h95dHKE37P
 9AaUIH6IcSXeF7LlzceOv37p3Ur3EqP/XCxJFrbEdwEDjBsp6Jq8zia8kKXWZbRjEsN+
 LS+ywqMQCzqQw/5vJCRIQn/oOnu43gVvJc/8/8LXU6EiBYtzmH33rafIL0QZZa+v8Ijq
 pwvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ80k/RD9GspCwJJKTAZHi+HYn5k3sMvAz3xATwxrnC+03Xlwc0vPk5/WO/VgTGaZYQwNiZ2aRh+Ym@nongnu.org
X-Gm-Message-State: AOJu0YwQStZ2q0SbqIGPcZxs2OGVQPsOJabBdvs9P7o3SY7vstfcMjkT
 lvBNLLJr0jXJNr6kd8xZU+t1JmVkQDcucqaT5vLb9fShHadSHx35
X-Gm-Gg: ASbGncsQoJZybE5yzlndhp7zY3FvTHvvI1uL4QzROyM5QPyr5gxVXQQnd6Q8+KMk91q
 8e4rkgUa8kBRqqGtH9WkcNa69KjRwBOwnnzH+nDvsMAGOxDofpreObv+XKeAwUtsz6BwTlBKwgx
 PlqEziE6e4GqVCOME9qXBgsg+TuN3+9HbezyA8PeXjVWSVBVlRjS0/nqyfqUPrqe83aTAbBcRdh
 OWsPJhXNgovp4+LbNI8YrXSVD+P6t2Lv1JXFSvuIlS0Rvn8vjIK1cwLMWYNfpMHokWCgWJa/FGK
 8uxtQQFLeVAZ2mS9xIv/5+gfUl1rz3P3IVe96/hkZXWpUQvhXbhNi4X50pxRUqE=
X-Google-Smtp-Source: AGHT+IFliQfIgdjw609gZArUOkETkbYUQ7AO1PPNmoQ9fIHEr867WkI4YZHC7MI9qYJVjPCoDA0dbg==
X-Received: by 2002:a05:6214:dcf:b0:6e8:f60b:9396 with SMTP id
 6a1803df08f44-6e9006aced4mr58603956d6.29.1741380322770; 
 Fri, 07 Mar 2025 12:45:22 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b475sm23144856d6.75.2025.03.07.12.45.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:45:22 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-17-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-17-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 16/38] target/hexagon: Add placeholder greg/sreg r/w
 helpers
Date: Fri, 7 Mar 2025 14:45:21 -0600
Message-ID: <029701db8fa1$d8c33520$8a499f60$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgHeIwpUtO2STMA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2b.google.com
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 16/38] target/hexagon: Add placeholder greg/sreg r/w
> helpers
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



