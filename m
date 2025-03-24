Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC18C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnmU-0008Od-Od; Mon, 24 Mar 2025 15:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twnmS-0008Ni-SN
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:48:16 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twnmR-0007td-9u
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:48:16 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e8fb83e137so38079316d6.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742845694; x=1743450494; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QO7GpzCXgTquyz3vQ/CUlrz1NksSDuCM8eqEnnMn0Hg=;
 b=Mb675xoDUmWsqYGaJlRmQ2ykQPN6M0+QKqnAmyfDr9vDoTlQINWFJl9RE0Nx8OJAyd
 BOxNw0/DlrVeFCmxop/CCldmf64AgGj83ac3rTpjYh43NNWCW/aorKSIk6mz08iEZP7X
 blfd9uVq+P2SOsXLgyrMif6pbulkCpukdiviKnNzbsGFrRN4iw53ygU8wbRb3Azx/gWs
 8EXnG5opRJ2Ufmcfz2lF++eChkQFOHYiBH0gWapo0zJkM56f1/lA7GqCKSMyTqVv5jC2
 EYyu+A7fG1BUUmhFamxFOZx0ND+w1PW5sFc0xlFJ2ugJ5/1UcMuzuAGYJw9NRwI9YBWm
 m3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845694; x=1743450494;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QO7GpzCXgTquyz3vQ/CUlrz1NksSDuCM8eqEnnMn0Hg=;
 b=KcPSCyVojsgPBOysg9QS7YQa47dTFgSjYLpbyat6UZV0k1fDLfu6KDAD+rElV5tyol
 JffpVE5QtKWE1dS0sDyzMWUE8PvdH4Jv6YPNFMVUgScqVJrd6QVXbrHB9w9BlqG7SxrF
 n65S8ydq0wsi6fZdafuBZdrRZiGKzxgkwid6FyRXWCDi8SPj8RM1srqAPnLHgFf8CJp9
 kqmzghlMNC3jC2eZ4LSLblxjOHlwV/ke0kIjZSNuRJ1oxUMX8Pd2CRimxtW8Wq5j3lvm
 7FhPJnCN5TqBx9RjXFPAlKWoOOmk9Sbm9l/h+/Ynqdwe5VNzlmFbs3YV6sLZZWZRf1q5
 A63Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhlpcK3exVi99URWOwnaNpCnon7QgmO1lhtFtfyTg/aoA+iJbqU9jN++vt95rAbbyYrmxXbNwtTUVQ@nongnu.org
X-Gm-Message-State: AOJu0YxG7yVsP0P91MmBEGdKfVEXV60L/N1KQ4wo6fPXGY+2HFheOu6N
 9LLZOr1pTpV+BWSNcNViYmTxd1Owh7/MEq7ynftzoZVyU1wwACkl
X-Gm-Gg: ASbGncurnKIWIBsWIbBRysh/5OkrmeyTN3B/pM6guZ7T/+6wbz2PRkKSVaY1p3r8F1e
 Bb+fGGChw7aBB4p6tC7lUuv17m7lGXX1hwq5XOAWxB6/HeULwm/ZvroXnvmHLvhFgn1BJS3USlS
 T/1nx21xOWEdLBy0+lNuD+zCuuM7Bx9CEsYwbFKp4vH8itW3BHt4IjLRDOpOFPMGnCvP89U20O2
 w8gQDaROoNu4kajkUvVtmgUqi9v2TChtTuavh5B0VztGfM87rHzzcVfPuj7E5tm/ZvoQ3GYhhDV
 Y1Rbw6bMEngUwqFDwGabqDAP7I85aFiZEsQ9/AaAqDFfzKlGSVTnt3dg1fe7tP8=
X-Google-Smtp-Source: AGHT+IEPUzR2k9CLuvX9nHwlh+R0CDGycjOh/VNTFOICnE3QNTSCUDrQx5Nv+hb0v+mgjHs1wwCf1A==
X-Received: by 2002:a05:6214:766:b0:6e8:fe0a:7031 with SMTP id
 6a1803df08f44-6eb3f3b9b97mr198865066d6.43.1742845693964; 
 Mon, 24 Mar 2025 12:48:13 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:319a:7f6b:e6fe:90fa])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3ef0ed67sm47945896d6.12.2025.03.24.12.48.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:48:13 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>,
 "'Mike Lambert'" <mlambert@quicinc.com>,
 "'Paolo Bonzini'" <pbonzini@redhat.com>,
 "'Eduardo Habkost'" <eduardo@habkost.net>,
 "'Marcel Apfelbaum'" <marcel.apfelbaum@gmail.com>,
 "'Yanan Wang'" <wangyanan55@huawei.com>,
 "'Zhao Liu'" <zhao1.liu@intel.com>, "'Eric Blake'" <eblake@redhat.com>,
 "'Markus Armbruster'" <armbru@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301172045.1295412-3-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 2/8] hw/hexagon: Add machine configs for sysemu
Date: Mon, 24 Mar 2025 14:48:11 -0500
Message-ID: <04b501db9cf5$adba9b50$092fd1f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQBnRK9gH0BRY5vrCSddsvIJtQ/qNAHOGmeNtlzvBwA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250324-4, 3/24/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf29.google.com
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
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>; Mike Lambert
> <mlambert@quicinc.com>; Paolo Bonzini <pbonzini@redhat.com>; Eduardo
> Habkost <eduardo@habkost.net>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Yanan Wang
> <wangyanan55@huawei.com>; Zhao Liu <zhao1.liu@intel.com>; Eric Blake
> <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 2/8] hw/hexagon: Add machine configs for sysemu
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> diff --git a/hw/meson.build b/hw/meson.build index
> b827c82c5d..91969d6fec 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -64,3 +64,4 @@ subdir('sparc')
>  subdir('sparc64')
>  subdir('tricore')
>  subdir('xtensa')
> +subdir('hexagon')

Keep this list in alphabetical order, move hexagon between avr and hppa.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



