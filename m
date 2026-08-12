Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394E4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBff-000600-Go; Wed, 12 Aug 2026 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuBfe-0005zl-Eo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:19:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuBfc-0006Cd-MF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:19:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2caced6038eso769475ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786551551; x=1787156351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jAcg2JV5PZ9blWYuVZytqqv4nSdL1MxLg/AZRWrprBU=;
 b=sKQT0mzYHjc8FUvei0B8NfV/h2x9E+6BXEewuP71VzCpXALmr5n14gbtOI4UDe599s
 9oRHookRNandyoDTBoGOIyBqkIN/4idcHgXUsaG1wgZxQnrbcqJ8zI81rU6/pvNTCRG9
 w9fT/diQKe0Ro9a3XirQiGVpNB2C61idpBMRsZdAjFlLzm2QLx00QSQHT3/rkBwt92vX
 Q2S5UqWJg5A6SDqcWX2s/4CEDCb7HnOeQmyC5Q+UHsrsxc5Q88GnS+BD442GOlaePVqY
 PczSgFZBT7qG85RPdDg8z4VoY9g0Xzy5JBOhfaJCNIPjxrnmTvy16qMZOYB6JWug61oV
 81WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786551551; x=1787156351;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jAcg2JV5PZ9blWYuVZytqqv4nSdL1MxLg/AZRWrprBU=;
 b=OgtrabUiQ4ZifyKWj1jZQl+ev2NBrFRWyPtjoePmY3lmayXGNFAky7EcMSdhyg5R/E
 T2PM6fb0U1CSwnDUCPDCWvnxHDMWazJwqwx/4QVF/2gEb/IVmabbqoVwVPyTAtU2E2tW
 FVvL+OeInt057v3yExO+wspQfyx4Fw/P5yGV3G9kGM/E8P3t1bUUwKo+eTd07ZZ50g6H
 ZcDGA9RZhCgNS93vLToiQzZxkX7gXCEOFUUYx9xgzFBhNr2Db9JC7R9JecRNvBU426uH
 +1ZzbA5PgYp/o8bPHSUhLyksYe0rVWFQvJ5opAVj8rG/I8vBH/L1Tq2Jw2HIJlclMDL1
 Vypg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJ3Jidld30j1QFnToVueOxfAT865p7ZUyHatZrySZKkI5NOqvwzTfMLLg/U46n7y802+AdAOAn2SeN@nongnu.org
X-Gm-Message-State: AOJu0YwwmEqT1WNUlcckW32m6mgK5FdLKx3ipyZcxUyJPP+AnpeeAfPC
 O/vYPPIzfrZGzm59ha2P9MR/8+UgkVScOEBf62x86TPK6e63/RX4sepponV/9sp6dT0jHal1PtA
 7VI6m
X-Gm-Gg: AR+sD10lkJMVOfnG5SbdfkvvZRKeBa6h5S0PpTxk/SxJNax9MlmSbV4N3gcTrU5OVSx
 04py+EesrbMK68EmwQwndaukQ5MOegTerWjKRnYCZFXlAPylJUU88DAWRUEqGW+Z7snVu2DWRY1
 9PTSPTtkhjWwOGH5Qdnk3ylfFDQcKHeqZPFyrCXc6nRRdVnmHQloE0KhOnh/wcokz/GjH2EdVb1
 lCZMXfwKk8XDrNADrkXaJNJHS1UIr+5OHIPKTc24tgHTYKJ88We9o+E2Lco1vghzhjRHVIsZ6qz
 wHYS+z3S0ZvBmcGusIpivlWmhAm55ZU2ag/Rylnq6aIaBMeZEITtbWfCpkKXJXpf1ofiiM43q+Y
 CjYuqa11AXcVoxqu8jpUqokc9Ws2vr4lhywjhqRUnPvpxbLYKhX4/d6XKbAs0j0uw/H5gaiwfEA
 yb673d9fav5sY8CmWUCXTOm7saFPwzxi6UsWlJFkGyesycp+BI657X4zJ375GEmweLfAJB9bOhm
 ED4CpzLp6I3G1dxfdpbxURRW5Va4RtsRGp/iYc=
X-Received: by 2002:a17:902:fd8c:b0:2cc:80d6:b72 with SMTP id
 d9443c01a7336-2d371e10903mr2003945ad.20.1786551550987; 
 Wed, 12 Aug 2026 09:19:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3522019d3sm9153165ad.56.2026.08.12.09.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 09:19:10 -0700 (PDT)
Message-ID: <a4771466-dd4b-49b0-ba84-9cd2edeeccb8@linaro.org>
Date: Wed, 12 Aug 2026 09:19:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/7] IDE patches
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260804170015.3128363-1-den@openvz.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260804170015.3128363-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/4/26 10:00, Denis V. Lunev wrote:
> The following changes since commit e1705a25aff35635c360bbaba4c2731d019a422a:
> 
>    Update version for v11.1.0-rc2 release (2026-07-29 06:16:08 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/dlunev/qemu tags/pull-ide-2026-08-04
> 
> for you to fetch changes up to 9a249de6ae86124b436b5e839e285aeb333ea8c0:
> 
>    tests/qtest/ahci: regression test for ATAPI read vs. drain (2026-08-04 18:40:34 +0200)

fatal: couldn't find remote ref tags/pull-ide-2026-08-04
fatal: remote error: upload-pack: not our ref 9a249de6ae86124b436b5e839e285aeb333ea8c0

Did you remove the tag?  In any case, please resend.


r~

