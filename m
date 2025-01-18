Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF2CC02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ3PV-0006Os-6K; Sat, 18 Jan 2025 02:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ3PT-0006Oj-FW
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:38:23 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ3PR-0004hK-5A
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:38:22 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so4979685a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737185899; x=1737790699;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fqvyK7+f012SWXxtKWNbx3TFj491ym0Hzq+UsmRdYgw=;
 b=XDJFA6zn31XIfsri/C3hVYwvZok1n96mQUqfNfGovDs6sjfFAZ9lmphltfCPUtheYO
 9yLyaBmkNf+MDXI/sapwIHLoaU89GWtnYsZ9LRW2n35FLzGRu44c0DR3iL55BPsxgBSk
 wHReyTe3ersA3kFJUg3BzrVWx+jwBfFPDzRR50OHF7vVaCW+Dgj20xhr69pcV5lMU69u
 z79AmUj9HcuzrPQt27CXimlgsOKuUtH+IzcEuZMKaUAjOmzKM/GoOKKFtXQvWavB/OxX
 kudlmSGXbfni1vqOgLKzoxZ+CI63lAZEkX7wC6qFWz7v72eY+oAIe3f1ZvnWPnlfaHCA
 czjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737185899; x=1737790699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqvyK7+f012SWXxtKWNbx3TFj491ym0Hzq+UsmRdYgw=;
 b=oulA2TIEWYtH6QpXYhxj4jRxBfZqjLAjxbNnsHTTe3WQN2BV+KnnUKgBMm81PioX2E
 53so+Ey1LJZRcnOkqmWou5o7oIq0Tc9hP0wrvoVF+R+SRLwfvDDK7YvVuAslUU374e+A
 DlsrV+TpJaaUFmUJUcsW2Y4amMP6GXV/hOA88j2sth/dzShj6JL3gi0hTyB1MgXPoyRk
 nCIBlaqrzMefm//7zPnehgrLl4gaF3t1dzw70gxl/jVZAQIeRXd9NAz3/tuP+nFbu531
 61knHCOiMi8UGZOZOCpHX5f1RtBoH9ttPCEx74pXneVEbWdkr6O0MRipu2Wbo/9snoKj
 nG1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX06ggoN8cyOQhoanqgy+3BEGogTHz/Ow0qGZjLncRKID6HwFCCsBK4H9PLSBuUIjCygXENSDdF50xI@nongnu.org
X-Gm-Message-State: AOJu0Yx4xPzDvfYszqXeTJpOt84+wTpDobeeYsCqurvarJ0MwBdsDmJF
 EFkvJIlMHwtmo4kS91SDVnzbtF4FaZQnjuWuvPOAtKGrE5idzvnDN1zlJJ6sQmI=
X-Gm-Gg: ASbGncuMU0MFMMlIySCbcRd8FJ2VqWa79dyhgrqoiudBMcqX4cGR46iGVoJRGKiSK9b
 YwYwMMia4dB0PTpuiwRKmWW4KNUp9b7cdfbu/62c2XbenXppsS5wHhohae42+QgXnpBTNd+bGgB
 ugNSwCtdx6ubIjtg8/7EtG0IDX16/i3Re2aA9uJ9ouvdi1knqdiLTnEATyxMWTPwIpovjS2v7V3
 CU9jHe/Lh6lwmmxLQw/SB2UppYil2klkuZ1A0Sp6seHgDVCX1ambiFAm77i/6BZEm49OlHqjaQ9
 b1k=
X-Google-Smtp-Source: AGHT+IGOk/wpCV4VfEvaMKbIinQ/mzblgVF6yMIMhngcUluetv1ynA+1FRshn3ZsqMRMW10S/hbdeA==
X-Received: by 2002:a05:6a00:802:b0:72a:a7a4:b4cd with SMTP id
 d2e1a72fcca58-72dafbb61bemr8407780b3a.21.1737185899452; 
 Fri, 17 Jan 2025 23:38:19 -0800 (PST)
Received: from [10.4.77.142] ([118.103.63.134])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab815f1bsm3227106b3a.65.2025.01.17.23.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 23:38:18 -0800 (PST)
Message-ID: <5c259a18-892c-409d-b0f3-f12b07a65c0a@daynix.com>
Date: Sat, 18 Jan 2025 16:38:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/pci/msix: Warn on PBA writes
To: Nicholas Piggin <npiggin@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
References: <20250117172842.406338-1-npiggin@gmail.com>
 <20250117172842.406338-2-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250117172842.406338-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/18 2:28, Nicholas Piggin wrote:
> Of the MSI-X PBA pending bits, the PCI Local Bus Specification says:
> 
>    Software should never write, and should only read
>    Pending Bits. If software writes to Pending Bits, the
>    result is undefined.
> 
> Log a GUEST_ERROR message if the PBA is written to by software.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

