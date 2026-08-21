Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60211C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxW6I-0007vv-ML; Fri, 21 Aug 2026 16:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxW6H-0007vh-31
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 16:44:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxW6F-0002vU-Le
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 16:44:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so1211007b3a.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787345066; x=1787949866; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y/WtSNodBLFOSTx8v3G5R3Tehnz6h5bwIVyaGr1P8x4=;
 b=lg/JswfwzzFMdJIL5lzcutTRmH4pQ2Hfk+ONzM419daFNN/lRgoSCkGxBmyb9jlino
 XxbqYdIEHljhmKRHjoYCvhxU7fG2DQ+FHY2XkrsLWXaLWBRJfPjqO2keujYDnUoeAQbT
 jFSOpewpL2VgrMuoz07uxivWthbW9v/+A94OdxROaQ8j2xQzwYGYtNZWIFwgPh0+iXvK
 3l3CyS9LLu/Rt+yndRor2gtWP6RGeNHfeFTVPH+3Ato8ze0nO0OefMhLlMV4KHTNWVVr
 nKiN9U9WZhka1XB5FVDCBhpflExudvFpPfJwWnnLpSbEUR77f/anzLFNFl37OxMcxC0g
 0YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345066; x=1787949866;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y/WtSNodBLFOSTx8v3G5R3Tehnz6h5bwIVyaGr1P8x4=;
 b=VDFSNJp1/EuPCRqmJ3eamCmbNGKq5y1FuD34zaQkUKXN/eTcBrZs3+UeQEbHkN7hoh
 zYatEYV9rhhLT5+74wNtQdu6yP6QMX6lHyS3dxoYCB05n1wpVzomu8qUTNsK5bHPjkbe
 IgOZCAqe/hJ9IAI7eOEF0yh4hbcWUcQma1HuJjeFLt2enp96hWwy62u7c4bzz3EkMZ0O
 jtVVmxlMYtFVpw0HlMuVXvh4HN8XBi9+DS96lIbje1UWGP7+u4Cu3W8pG5mtN5iBopBV
 GaDpyGJCvFsMUDJP/QDgr9RLaSVTdTmjLW3qNkrxSqWeKlRQMBljP5Go6NdD9dVQi/My
 XM4Q==
X-Gm-Message-State: AFuF++ktF8286rBEizW6vdvQ7Il17j/6lxiK4k+p2w/O1oxtiZ9KkTdB
 yMQ0ZAKa/ogDZSd4dJnt1mli2d0JIa0pWFXv9sUoI+RmbtTZqe42l7taJ2jCvWpR7mlSpa4gTPB
 EtSv+
X-Gm-Gg: AR+sD13vR/BQgSh+tS11FhUIPOG4N1S/HCruDiSUMmvgi7mVKcI+Yn1rANvU8/VO6s+
 jfcW8gGpSD5yRYTLRJB33MEno/1BWiIfzK+YtqRMD/r9BdQNSADdRx1woFjRwC2Hsd/0ME8M7mS
 78uBruLRAqx5EC4l/wyATPsxKn5xF9Wcfh9m6xyGmVVjkxg7hiUVaPuhAACpgU+OA075uw+ZyCf
 bkuVzZClEVDvfuVvqLGyQlhnbPyGV2PnTPXNhCI4AONVpqUdKgyn32fZ2h7q+qL9uAkgg8WPnKH
 Qud7z7nxZ/olzk5yCEJ0EzMYzXY7rbofIGqLgfAMSKfXBxUaXRB9IQMRbG41dePQgy/EpTQ9m7s
 VnSN+FEDm3Kr49ZUESt436DmvpxWVTKdwiBHWWTUJtlKSJEEfSBGtGpT6N/JSqIs4cfDQHOxbFU
 MFV4pKlDsbVi7fPutNzF50CWDFMFx6AmYYMHvX15RBrpLHOmbS0dydgznLR1p+8NyjI1FydVaWf
 AUxxLbViBSQemFOMZtFjPXlml4qxAC+pe7piKFhbQw3+vAzzQ==
X-Received: by 2002:aa7:88d5:0:b0:84f:3f5e:f072 with SMTP id
 d2e1a72fcca58-8520be6fd83mr1885302b3a.10.1787345065545; 
 Fri, 21 Aug 2026 13:44:25 -0700 (PDT)
Received: from ?IPV6:2607:fb90:339b:bfd7:dac5:d94a:debc:5ef7?
 ([2607:fb90:339b:bfd7:dac5:d94a:debc:5ef7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f151c7esm9143b3a.48.2026.08.21.13.44.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 13:44:25 -0700 (PDT)
Message-ID: <42b7ff75-6d1a-4486-a2a5-772dd729a780@linaro.org>
Date: Fri, 21 Aug 2026 13:44:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/ppc: PPC ISA 2.07 flag cleanup and updates
To: qemu-devel@nongnu.org
References: <20260820142717.337686-1-rathc@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820142717.337686-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/20/26 07:26, Chinmay Rath wrote:
> Chinmay Rath (7):
>    target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ALTIVEC_207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
>    target/ppc: Reorder PPC2 flags
>    target/ppc: Add ICBT support for ISA version 2.07

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

