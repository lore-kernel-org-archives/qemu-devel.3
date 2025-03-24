Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40C8C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnou-0000xI-FC; Mon, 24 Mar 2025 15:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twnos-0000wt-AE
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:50:46 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twnoq-0008JD-U6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:50:46 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-47663aeff1bso46785231cf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742845844; x=1743450644; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lB+t8NIN5zmryZrQRnHOEKgPh/WA3Pb/vJrIyB8yj6M=;
 b=MxWv3tkJz/HAOBTbVQSzRqeAQl7A2AjFk8cUraHj7T+GTYPN+Ia700VpwGQ6fCBSFW
 csb9qP4GdJ8z/Zjc7BkvIXDrzOhFHqLZeHErpRZQA6qZzYtp896HIzOBpT2uQ+QFLmX6
 c7ihPDKGE8qV4/nAG7VWC8gLaQRTFfGELpf4Ue1ld2jeg6PSNuMq8nzCARCbSohKBlQ9
 BLXC/C2z1/PX+7ebLbmbVZ0Co4TCZVKdJyau2Ygv2rFvjixFNpND4UN7BDVaYk86KPbA
 uoFCkuo+KAe1cT5VA5wsnTqKbcJYST9ONjDa2D7WnzYHND9DaT5F2QaapT+IZ2taO0jT
 iCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845844; x=1743450644;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lB+t8NIN5zmryZrQRnHOEKgPh/WA3Pb/vJrIyB8yj6M=;
 b=brarsZTzJucRgZsfnOvT7RSxPryX/5e2bPN5U87dW0qG65PN8MweLjaTBgDyNwAvz5
 oMlxg6Iye+VsOukwJ1E6X+kAnF6F21xiHan00Ro4yJIAEOEEsX5V/f2qN2fSzlX3K3XT
 rCnJfwMRJkXMkseup/wQiq2hOR3rJfq+NwRilX6ZTaslpv3YHjPcWSigQsgdVcutagky
 lHXclC6atQqWMOV2AW3RAPXP081KRBnhSd6ZvOOWdROw4coflwXR3Rs0UeG2EGcKIiqz
 +tiYDSy3Qr6rJ4IT00YWRJ5IhzT5Q4QiBKsd5RoGeuwgzvST2fgVvs1H3tPcClkWCdZq
 Zl/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkiESd+xyGgKOUJG6exw+G7M0/d5984Xdibh1JnVuNPVNDbBrZWYb3eHrLUtmfoWTh7pW7fff9jIgF@nongnu.org
X-Gm-Message-State: AOJu0YwhsvXIaCZKFNf78oWMC2nPyd2L75LIH4UNUjzCKTjpX6LTstMu
 Jh4XbSCtIHlwTI/kzb78J71rvgKU1ekFDPHmIzN4LxptU2H2i01pKrWtcGMQZ+w=
X-Gm-Gg: ASbGncs/D9N1HJRzMnojozi8tq4A8o+dhM6vyMj3MusVy2wL4jlB0SHuJ04sffNTbsb
 j1nlxQwxOx+bDkGGINDGe7Sa5nG+jXKOc11+97atborR10bNv440hjbIcOm8VSYi3c/opdLp0Cc
 5ofrx6UM9xCmfkpgJCoIlDegs1vYRAG7aq+z4XMGydf8i+FoRuBldcPEXagtLz8edd3F4HrZnUX
 7PbTJcP0HdvN8cdDuOW5LOnBbaPBehf5+KfMkHo4fIUbADMCwDddEnN6fo/AUhh5i8b0al2PCU/
 +rmcnPQKkO5trdYekzrgs0r4mWh46CbGlQYw+fH/yNlCKT2sqDP8+EYmJW65i4k=
X-Google-Smtp-Source: AGHT+IEexRF1bxTtLRxEnrLB7jzSwVpz9Ls6uPO4RUphRWtWDrrUceb03PfZgjaUi5WRSFb4iPlggw==
X-Received: by 2002:a05:622a:909:b0:476:ff0d:ed6c with SMTP id
 d75a77b69052e-4771de115f9mr218659991cf.40.1742845843611; 
 Mon, 24 Mar 2025 12:50:43 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:319a:7f6b:e6fe:90fa])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d6361b6sm50725981cf.74.2025.03.24.12.50.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:50:42 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301172045.1295412-4-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 3/8] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Mon, 24 Mar 2025 14:50:41 -0500
Message-ID: <04bd01db9cf6$06be1510$143a3f30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQBnRK9gH0BRY5vrCSddsvIJtQ/qNAJ2Sz3itlev+bA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250324-4, 3/24/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82a.google.com
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
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 3/8] hw/hexagon: Add v68, sa8775-cdsp0 defs
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>


