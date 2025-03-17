Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5CFC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGlN-00037v-F0; Mon, 17 Mar 2025 16:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGl5-00036C-GX
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:08:23 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGl1-00007D-Un
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:08:23 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c597760323so57063485a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742242099; x=1742846899; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9NYGOcCw6SoYA6v2e93u1bqwnABs3nwQw7RLHYZ/QgE=;
 b=MFsn8bX9w82kKqk5W32rEB/f7ZIoFREtdCy9U2tdTkYeRdWAWzXoSB5BswnNMpvoFv
 48IDeQKnVlUK5gquDes6PHuMFbxgJpoJu9QOzRCATN2rtqKqy0hI9nZDkYmnrZ8o9HTu
 whOy9SzehKBxVJtglWbMJ+w7ycUQFhPsikLUR4H/GgziONK58aBZ5QzFkmhvLD7zuaDa
 h9i1v1evu68kMitYXqPlB+E4d0sGaCx3RA5rpRfz80nnoFIbp2FXaEZqralyc4qZHg5r
 3anr5UuRAqvZ3P9cDLhfKj7Ivf6qZigY4sp9DE0mMGc3ljZPA5QBH+yjte7Bj7hL+5rL
 DFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742242099; x=1742846899;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9NYGOcCw6SoYA6v2e93u1bqwnABs3nwQw7RLHYZ/QgE=;
 b=LAyKrau0Zghc1J1Y5Qhm5v2f2HAgBc/qAxDDJAecSBOiq+O9B8sPb8R35CN2N3Ultv
 uVYwPMOTFJ4EkpViroIxGoHlHdpaYdN3CwBkdFDqAv4iGks1LhfNh8L9feWUDo0FD4WT
 oxwj7TuVZJ2TK46GafA8ChxNi2m2+oCIOUgTIY5dAVpgaE99vkHuDW6q8F2edHKT9UPC
 Oq2psKYecmyM/Tt1NqItoCapM+PekAEIFHF33NPzadFP6l4juP+SwQhJfIf0N5iOQztd
 PPkXiZThiaKF87kfLqX3DfyCK5nalbojU9czZ6ThGyLLllUXMRm+y5OwhBRDftKCK9Gn
 ykZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWKCUQDsDMDTH5IlfSpY4I1Xe2FQKdU6KbVgFynha3R5pnPi5ZF9IIpBV8qbzTRDD5jWKfjye4365X@nongnu.org
X-Gm-Message-State: AOJu0YzJ3Vsvr+NakAElhdf/Y1rfCeZxQggqUUhcIX7oXvynlpHNC9E4
 fyGGo2jRQzyGI3sNhg3wu7opKAdhZesjAG9nZ04yiBrx/sxsCGxO
X-Gm-Gg: ASbGncuvfOzWVANNnKb66+TJ51ny+4RZx1Bkdfx+9c13gpYWMRdbRN4GcO3SsBufYTd
 9B8HJGURuDjyqlkmR/NlRlks9Va4f4Fr0rtVnjFW0mSggqyvpZW+hrSRYnkQgCTG8p1IukrK5XF
 AjALejiNf0B45pONSxR9KgQjt/HKEheGljbtTDNlFmtZwG2L4F3huwms0nbwatDvOCSeV5j7ia0
 AqT6w8ljThJ2ek6BlRtqBQb94Jp12FQDmSQCNXWy2N2psaeQXXkn6kU9DdH/VI5S7twIYnNmrsh
 AYq2yVRqBrYtivjdX1uyAx3TbAmXDRm2zeGwBwiLc6HppbtWQDGWlqashv9pAAs=
X-Google-Smtp-Source: AGHT+IERV5Z8b28znTkzywvfrR5h/z4aBwOXLma0aYb7v938jCzW+9/wTX6y7u5K7bZ/lUrvpYaNGQ==
X-Received: by 2002:a05:620a:454e:b0:7c5:54d8:3d42 with SMTP id
 af79cd13be357-7c59b1e84f7mr131900285a.31.1742242098882; 
 Mon, 17 Mar 2025 13:08:18 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d89b16sm624241785a.92.2025.03.17.13.08.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 13:08:18 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-27-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-27-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 26/39] target/hexagon: Decode trap1, rte as COF
Date: Mon, 17 Mar 2025 15:08:17 -0500
Message-ID: <018801db9778$5311b260$f9351720$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQFM/9wPsvfirCA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x731.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 26/39] target/hexagon: Decode trap1, rte as COF
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Also: handle rte instructions at the end of the packet.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


