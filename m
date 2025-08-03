Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551FDC87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiMwu-0005WL-Gz; Sat, 02 Aug 2025 20:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMwi-0005QG-JV
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:51:32 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMwh-0006zi-4I
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:51:28 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73e810dc4cdso1206850a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754182285; x=1754787085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x1cE9hK/cnHcQguVA151BlS5RQvAp80s9GOZblSGtrs=;
 b=IuvJlBtkHwd15oGdOpurGoF1+OAcTMaXtyDDxXYQ/cz/qZC2fSRACnps2b/RVr0Vqt
 AxHcLwrrxFWKA68nTPp1AtYTXg57LbIAz5iJFRjosLTGqZ0Kv8Ijyq+8/SvdluUqs+pn
 k1sOU51jDFmLozyII7aC3nYs+dhhx2zh4+qXc6DFUsR0cOtFzGOLbJjGHfA3MJlidpeu
 icQ94SIRWe9craTOqtyxLE1YxX2ylDFfS45LbNyDBJjjjIYMBe2i7H9ge+LvNtpFS1yz
 d42IlBZwf2kp//y+fTYEdHhZQtdpkX71ZlrglfN8iFO70pisyjCBB2pamsAa0Es7dr29
 JJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754182285; x=1754787085;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1cE9hK/cnHcQguVA151BlS5RQvAp80s9GOZblSGtrs=;
 b=peuQ6xeh6leRxbtVptNlGz5P2G2fH3tMlob/v9O/TCLs2NXOutHkSPooe3QXD3vVkS
 XmvULlumsCJfPMGSCMkJzbglEnGYuIlDklrvE9afxSQsTbQvj5JmOE9jCpzT6aRcZ+1C
 +sotY4wWhE3xWC9Qr5ho/KZSqQAd6QiOU8WR/s7FP4FviXsqhFevWPvlBP5nJh5fD7Ar
 bzLe3vkHG9yfg2WKdu/LhlfH5HhiBiAhmnRBf5Y4WDlgn87bbzQjxBbOPwXJ2++qnTXD
 JNx+l9EhS2ydJsy4BoGMJl0yeo0DBPnY1WtdOftnREFyMRp9BZaihgeCIqKXTIVG80ok
 KnXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfN+BL2Y+B8y6GtkY5FrQ66vRGbWpnPuXaq8ijX//J1CUnHbNiNpK+vOtojVW8abB+tL2xYzcnWeo/@nongnu.org
X-Gm-Message-State: AOJu0Yzorwr2SmDTEtJnfcipzDujScCwXXAi8PDQZEs7BvLaFx3YabsH
 hBbyRy+TBVxPMAQTbcBKRFoxFTFxDSn++UlsCaBRsswS10nyne3aEBzJngNxZETvUys=
X-Gm-Gg: ASbGncv6kyETY8JHGOMYeBIEE9VXyrUwd9KMIvuspMD5R29t3O1J+RWqht6le57/GBs
 1rYFfRjnABoHowFaFVvO4YX9KdxhNvVTE0tDOawpk2/CDDH82RsWdCroGhBIG2fgycTIJlUHZf6
 opPE970r4nAG+fUW9rcbpMtxi2GnlXyy78U/zSMQyVqFCBxnyM9sGrXDtUf0qwd5CNcE+jHawfV
 FOwD0izmtIa9mGngooH8Ci6/SgwjTYyq+JVxluReDGRo2TtbB6OzXaJSZJB+xBA5RqvJ9cSn+YC
 sY2SDRLw9eVfAlP+CxaUPpHMt81CSCRqE6fzarBu5AJR03Nld69uX1hst2lIHa19ZKh2falHEhn
 r51uJ36SvuAiGz/iIiyEVdx8usFz/A+JklI/cDInFVnmykcbNSFCddKbM5ff/J21D
X-Google-Smtp-Source: AGHT+IFy2a5DqUNifrV0ebch4efAStPUmQEb7fdYdaauuvxKWua5I1LRk6gFRGZa2GqlkA/AP7FQfA==
X-Received: by 2002:a05:6871:58a6:b0:307:c097:a179 with SMTP id
 586e51a60fabf-30b679116c7mr2426460fac.28.1754182285155; 
 Sat, 02 Aug 2025 17:51:25 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a7390b47sm1807053fac.21.2025.08.02.17.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:51:24 -0700 (PDT)
Message-ID: <ae4bb892-6cca-4a63-91a6-530149e7755f@linaro.org>
Date: Sun, 3 Aug 2025 10:51:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] whpx: ifdef out some x86-only code paths
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-5-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> @@ -414,8 +424,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
>           LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
>           break;
>       case WINHV_EMULATION_FNS_DEFAULT:
> +#ifdef __x86_64__
>           WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
>           LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
> +#else
> +        abort();
> +#endif
>           break;

BTW, are there import libraries for these?
If not, could we use dlltool or something to create one at build time?

Since they are required for whpx to function, I just thought it might be easier to have 
them auto-loaded with the executable, and functions dispatched by the linker, rather than 
go through whp_dispatch.


r~

