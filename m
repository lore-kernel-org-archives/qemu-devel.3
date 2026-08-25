Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EB7C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyx2O-0003kY-Ow; Tue, 25 Aug 2026 15:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyx2M-0003jg-TB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:42:22 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyx2L-0001e8-3v
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:42:22 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so350985a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787686938; x=1788291738; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4OvCPxAp5DWp6OfYg8j3tVl2y5qbHOH5YMBpoY1Fy/Y=;
 b=w+MaZ+/+snIrAwW9d3oc/1uTtX7WvTz2oZFuU4hBqdcZEfclWNkrUmaaNjcDogTxOq
 o0V2uOB/bJQZdZv55WZjzGUawp+2I6JdvDHZM/MuPsabKCPmeM5F1bbOkqWuwypmz88N
 9Sajv/Cu43yZvMLqIpglxfS8XpUubGOm+/x4/giJAZN8mmagPPNYLIY5oNcryrtwTzPn
 yYM5T/KcNvhcKT1Pp56WNjQvOYAfij2ZtSuSDJdK7qzVWHMjJmClBoBnGQnGJl8fX2Be
 H1rALOvJZR2agIx3l4Ls8XcL11LdtCW7XO8r1ckkJl3SFLBMj9sswrjuNdjINvrVbkIv
 jhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787686938; x=1788291738;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4OvCPxAp5DWp6OfYg8j3tVl2y5qbHOH5YMBpoY1Fy/Y=;
 b=YSRyIn1fHPazmuVraHgbGdec0Ix+7SUiRg/cOW+qg0h7XuFYy/18tAcHUHj3eurNJW
 YDt4MAcTKlCGxkONLWcmWR1gzP/aPMDVIrRvfIqFCedaFTys2a8UQ6o4cx0WirgDYmtv
 RKxzfeKByhVXpW6NIoR7O7GYhO604IkNDUD9a2TFDeyeigdTCwu/9q1jqnQ/ZdiHNoX5
 hwr05ip2XD1lRUNfKhfz25rSJB3sHxCRufIFDp2cdHYokmLCxfCKW6Lbu1M9oa5egzCQ
 zslleb204uf+/uL3rlqRwqW1GiFsvxOeA6YdScPVlkk3dVdOELCl/61FTpP6w08a6nKn
 szAg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxDwnvHtTx16Y9JR7YTh8E4FtLsKeSDQWMwzRTp1JeupPX3XLT3uChaTy6slwKy6whbgJU1UMrI0Pz@nongnu.org
X-Gm-Message-State: AFuF++mak5NmPRYYU+qbMrn0LQUtD/I+UKOR3GgDzyJ8lKjvLiqQRuGU
 dnFj/TQLLWZlRxHHLrBTBUaK3QDh9c4xYUnVhLACpgcGoW4YeqrsESVgyG7B6Ayvkjk=
X-Gm-Gg: AR+sD11c4LSmzjJ1X18xdBhsqsdcDJrCXzlzg2BSg3FxAW8fVeKTQTxVryT0c/loNgP
 ny90EUW1m3c7HRwH5Op9HfwqxUC0su15geuWtMt6P5MzEjzYn5Ol2JZBDjbol6Ud6CVPVWpiT2C
 ov+8yE6DZdpcRIayfIMQWk1PvZA4ac+Z0zXK03xLMjw8lGQib5OLu4A0hWyfFmBJ/lwvZuNkRfy
 wNdxriwnryUJwUJzJtjatrRnZ1dgHIHC19+FF/Q+R1/QPumLRKHeOJzJAvhaIyyAA+wXwk3qlKl
 i/iHoNp+Rcqvze3sVgSCsVJ/rT8V33inMO4MzYAjUdDvcnIJHv0TtU6H7WEm5Js+5qGD4Zq8st5
 b9TCJGxF1RfBvZd16RCUi09yIm0736IR3xRwfoBFA6ZZO4Qls9HerMzuonpLEGenQQ8DnDVLpjy
 UXqem9FQCo2NviBpokrOUy/iQp0vgpTDuEir2ANEgDIfZ5TOs9WEjJ4RhT2TNeJ06HIspEpEw7o
 6YmvYt7Ba+mKVSeHR/6MRAjx9PP
X-Received: by 2002:a17:90b:2791:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-3966cffb1c7mr3439864a91.0.1787686937803; 
 Tue, 25 Aug 2026 12:42:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39667fe29absm932516a91.0.2026.08.25.12.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 12:42:17 -0700 (PDT)
Message-ID: <fdcd14b2-c10d-43b2-a14d-3118c82c71d0@linaro.org>
Date: Tue, 25 Aug 2026 12:42:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/hexagon: align exceptions for user/sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-2-brian.cain@oss.qualcomm.com>
 <51289d66-1d42-4f7d-a1e0-652150f45a78@oss.qualcomm.com>
 <6a6549ed-24b4-4e18-a3a8-0fe1239404d3@oss.qualcomm.com>
 <dc805d66-fdf2-48be-a643-295ece2d2acf@oss.qualcomm.com>
 <b505808e-e703-4d8d-99ec-35713179e33a@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <b505808e-e703-4d8d-99ec-35713179e33a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 8/22/26 08:46, Brian Cain wrote:
> I arrived at this belief somewhat backwards, I guess - the file-scope 
> TCGv's used by other architectures who do support MTTCG already, and 
> our results using file-scope TCGv's on qemu-system-hexagon with MTTCG 
> in a downstream fork.
>
> But after digging a bit I think it's still safe/appropriate to have 
> file-scope TCGv's concurrently accessed by multiple translation 
> threads.  Because they are merely a reference to the state data and 
> not the data itself.  The state data is modified by the TCG 
> instructions generated by translation.  The TCGv - the reference 
> itself - is probably immutable, meaning it couldn't be made to refer 
> to anything else.  Or certainly shouldn't.

Correct.  The only thing stored in the actual TCGTemp structure (of 
which TCGv_i32 is a trivial subclass) is an index into the 
thread-private TCGContext structure.  The tcg_global_mem_* temporaries 
are reserved at startup and are immutable thereafter.

r~


