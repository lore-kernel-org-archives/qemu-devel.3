Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CBAC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGHJ-0002JC-4f; Mon, 17 Mar 2025 15:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGHH-0002IG-Iv
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:37:35 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGHF-000268-A1
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:37:35 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e89a2501a0so47933486d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742240252; x=1742845052; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bcORCdKxZx1T06njAsVA26XEYjHdSPUzJryM1Dg7U/8=;
 b=a2LPx+oO6kWb3umXubFWG0sJw0AqbxYZQSvbmAYDa5NNmdTh/bqsRHvSSMxvJ9zShu
 0h1QNVAhZqaZlHi5/y7mstzaX7FxQ4koxd2nH7PBs1sNcg5sEHfrghN7AjRBCZBpdLqr
 q0oFQzGCnZ+HAIXcpFgVXxCLUaJRQgtAc9TpFY+01lrErNqLzu0F5hnTwX3RzYT1M2UL
 khaZ8sGOg0BGI7WXO28h0yklmqxfbNjytyCiu5EI16/aI1/GKDPDhHyaCwUuMYkp18KL
 RgP3uePEUTH2zex8788p4YLaGgM/MXZYTVh4DiQnunWPEpveGCpL//ApxREA7EA9NRyx
 34jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742240252; x=1742845052;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bcORCdKxZx1T06njAsVA26XEYjHdSPUzJryM1Dg7U/8=;
 b=giVupgJQ6H/zvZa9QLakXR1Ff3/cDj8Ga6VZ9swARK4eO3e8unlJCMQ6UaOTc4cIu0
 cNZKOeRbhAYl+3rFgoA09WUq9PeAiiuFUT8HoJBRA81Y2izo7dej7c5JhEHilrl7X6bp
 NT9swGqWbTiUTgr1cl5mALsWu6KgtDidLXHSeE/sXZfT4+7lc+49IlwpfphQX4JEiLtm
 airxeNAzasSvVaL16dPrhIdUlLvqyY+6XuQGM+jmEx15FwjM2Oj8qttTlk4II2L2buJp
 MLYKYYxPqYxJllc7hoy3JIRkfFE1ULKFdqO9kf4LJW+k4i9W9Il+hKZVPuW4H32XM7Yn
 OtUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm/xj3qNt+8o9PMswoxWobAAJkFOwdSQeQ2JBv2Tuo9epUrUlGmuOltr1JBJJ3dlhSvoIvnKZBUTE5@nongnu.org
X-Gm-Message-State: AOJu0YzVrtQAZgrFEBOJE9cQuv6utnPKJjX1ye2fDj6r/hXvwdTKQFlE
 9sH0syryEUt35RSIm51tg+Oj5rrh5MyYuc3PTrnj71nVpI0Xo0lz
X-Gm-Gg: ASbGncux4eOttb+2M5/HkfUwKKCt6KYc7XhYFrLBOSVAsbespB+kx9HJA+wae4WgRzY
 Lp+nhNS2LaI01a/KoNJiOj0FCCadlcDiwpcYpWR2bNmBUkUksLiZDovdPQoJMw9OL8CQC4fyn0c
 HiRHsf/BM7A97LVrRfrPoF2xc2xF7F6cj/OAj9FdetdAOFA/Tza2+8taNGv3YdY21Kes5gdxJly
 imP8esFXu0dTr5As7Po3ErgnUl036uH0GbCPhel42wX/TooAFR7E7DwIdjr+FP2RLEpuFUefRms
 VJ4Qp841n5N65vOInDVTKC06/nTd8XMz8XBGVMBccgzLNYbTeW9GZ6Qp/tCYLUA=
X-Google-Smtp-Source: AGHT+IFSYWdllLxgY6Aw8hYEr6AAZx2L9C4lsKvFO0SPFUFZcgvYBagvJgzJ8t7TuZwVFXgxtJRXGA==
X-Received: by 2002:a05:6214:20cf:b0:6e6:698f:cb00 with SMTP id
 6a1803df08f44-6eaeab09fddmr230218566d6.42.1742240251999; 
 Mon, 17 Mar 2025 12:37:31 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade3501ebsm57952346d6.116.2025.03.17.12.37.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 12:37:31 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-16-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-16-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 15/39] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Mon, 17 Mar 2025 14:37:30 -0500
Message-ID: <017f01db9774$063ec8a0$12bc59e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQNdJo75sudY0DA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf30.google.com
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
> Subject: [PATCH 15/39] target/hexagon: Implement
> hex_tlb_entry_get_perm()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


