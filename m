Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B72C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9Vv-0005up-7A; Fri, 11 Jul 2025 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9M2-0007IV-1M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9M0-0001cv-Hy
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BjT5C0U0Tu2Ht6ZKpGr+ItXgkLdwD+S+4e4a3sAFVMk0sfSIkRbbA/ScSXvp48ibVRvIu5
 4Cabcfgr7iAuMpUVoHBm/qJRJk1XbiY/VdSqr578N4husmLAUi63MFCKMdTuQtmkXONKui
 PIHXE0TPcTZ7h7lG+VSTmMItV1ZookM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-EhMK9OXqOwm8VRmDl17ILA-1; Fri, 11 Jul 2025 04:43:29 -0400
X-MC-Unique: EhMK9OXqOwm8VRmDl17ILA-1
X-Mimecast-MFC-AGG-ID: EhMK9OXqOwm8VRmDl17ILA_1752223409
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae6f9b15604so63682966b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223408; x=1752828208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ksq9KWIgaUK8YUfZPgAnuPE/lwJ/60KNivobno7IHe3rcArY3NjInwuabinhQAWAl3
 Ohqx9vR4LuDCFzddJo0ZpGmNCw0Ve9txRUhBglZrKo620F7s+qjMHPF3l+eDyN/Vv12u
 Acu3AHkWMH9Ko8LcfrXTYQ4idP4Z8f3IgfLFucehYggUC5MHsg8WyJ7UAqfjP8G4v0ll
 VkdTwTFGCHcj+C1vJ3gs7NhbTpkl6zvenu/qDbThKsLv1UeU+MjGkqapcT/OKp6yHcPs
 +nGEH1n9joixx4z5Q5fJTxahslEABWh4iTBRR+OD+fDjBrK4P93gdSzQ4kyH2if9LXH4
 tlCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc0xLGd+NIuCjmO1qt2PdV8zLcufQgBBbEJ/t0QYoP0oxkAdWLau3dMtxzQQVUF+ZRRGyFMtFudZa4@nongnu.org
X-Gm-Message-State: AOJu0YwKHKx2dUvEGS1098DjlUbMtIB/o/VOLXtNQdnGTKSHPqb7t7+E
 0qsIiQf0dgALLKXqm/ecvDZsNb8Ub8YRSpcoO9LxzHTmYfpZcz89xfuUAgGDcNJwtV2ZHTtuGSu
 cM3XBJVQitUw8O6R0kPE6L+DRV7BuKsqIrqXpNAPF0dtrX0O5MnnbwbPz
X-Gm-Gg: ASbGnctLrTs5Stqi4s6qitzadVGE0MgPL3EetujIvsDOtvvWPcEDBLhDBSHOcubBDVD
 YSCOcB0/pKA4B1Z1ldN8F0Szb+gN/NB2rsy/B+fJAoyaTwHsx7kOQx8j7PildZAdn31O+zxhVu/
 5YModzWMM4Sw3IVbSl1zgomYHQfPJl0jK8N6niBryxP2tfQBRfTskE6F8sQPfuN3LZalOvRkhjy
 y03X6NWP4yXECHYCW2Dbxllr5sNAfAjAOZLlOv0oQCkQPo4gS+xP49T6G/2m49onHvl3emRYofa
 GubSTqTaV8Q6rc2UpAOUHGM8sfdfdkC/wShybCvL/xCZeUzYa/4obS3wABFRmsLjH9jqgI5nCg=
 =
X-Received: by 2002:a17:907:d7cb:b0:ae3:ed38:8f63 with SMTP id
 a640c23a62f3a-ae6fbfa602dmr249263966b.14.1752223408562; 
 Fri, 11 Jul 2025 01:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSNB+OJxhwy3ougRKUJAVEDk2jpH610SMdnRFczK7mbZOl35xmhevEuYc3OusUGV6YjOAjkw==
X-Received: by 2002:a17:907:d7cb:b0:ae3:ed38:8f63 with SMTP id
 a640c23a62f3a-ae6fbfa602dmr249262466b.14.1752223408086; 
 Fri, 11 Jul 2025 01:43:28 -0700 (PDT)
Received: from [10.35.88.123] (93-44-61-216.ip95.fastwebnet.it. [93.44.61.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7e90c4dsm266017066b.19.2025.07.11.01.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 01:43:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] i386: Misc cleanup and fix
Date: Fri, 11 Jul 2025 10:43:25 +0200
Message-ID: <20250711084325.457952-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630080610.3151956-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


