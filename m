Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2C4C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQLQ-0002rs-52; Wed, 25 Jun 2025 09:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUQLH-0002nX-PE
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUQLE-0000Xa-6z
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750858747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iu8CFEtKC/HiF+TG6sM9nxztvsPdDE/LPA2tQJ0cDlQ=;
 b=GgE77K0Ns1pxu7wWisv5wb92sRi3xmMtCI4IZSPfa6DZ2wXggiPcNOajF5wAs/VLKO1Jde
 77q7TYTfLDd6Edk/Y3yV+bfwiETZ7aWRP6yBDallhxNux0u4av30nbqHqFwDALns1nurGt
 NkJ1EnM4MJRFrdpmk3hldrzEq4D5Ozs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-bKxrV_HgOXuBOa0nEYUu6A-1; Wed, 25 Jun 2025 09:39:05 -0400
X-MC-Unique: bKxrV_HgOXuBOa0nEYUu6A-1
X-Mimecast-MFC-AGG-ID: bKxrV_HgOXuBOa0nEYUu6A_1750858745
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2365ab89b52so14628355ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 06:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750858744; x=1751463544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu8CFEtKC/HiF+TG6sM9nxztvsPdDE/LPA2tQJ0cDlQ=;
 b=usCe2Gy3Yu1yaFGaEiymHj+hI+rJhsu8TZBebHmklgIomnHePRU/jBZLqBnAOHFk5A
 ok4D3DebSckih0wuwjKQJ3UafccDjmKxYqQtpNQHBKzIaatobVUOVM/vXigUpEhp0aaC
 g+Yx14lcGs6SHgfqquO060gTa7XwejRLJdW61lIAoU9gmeoG85Itiro3XZPXKEm25jDx
 EfDKQ0nUY7wJTo/eCDDUk0qcvD8f9L+fQrtJYq16Hqi283xTwjmiy5xP+b0b/QBzqgLo
 f8IoFkiLEuyH+ZMTJeg3igKDxQcCaihhRayx6tCxCHXutuxy7Biv8QvbF7335AApAskp
 yUxg==
X-Gm-Message-State: AOJu0YxscgzEFltEnLQqEE950NNnCN2XnANVY/H5z5moMrss+v9RctpH
 EbEJRCPw8i9n9ZazobiaeG30mAg3XkevgjlnoICMZgNS6JjlwZwxfztoA7LEkuBIiQ8K51I5li2
 RvNzYksyLcn1I4ouKiwCw1Rogb26t44BTblLbadyxiulIUND+KTLct20m6tNWo7ipIuATS9f60s
 PAZ3tNILRWbxPmTuMcIGAmJHyZvtwks4H/xnlENQ==
X-Gm-Gg: ASbGncsWUTqII5igl1c0gSl7wcTlrqLJowzscAAxw0V0lnzrQIE3ec+5/Eq3mxueFbt
 xsOzOI/DpUGCZKo5xMZWstU2E1MNaVUVru4y/y9Cusa0OecVmStlM8umxzDdbc+8hCp3ifrzzvM
 a+ExwTqIPNjw5mMT6Pfh0fPWsCEd2JqsIVw+wysKyJTaPgq23iVbZhsRisKTDwxNUdvaTaC/8y+
 PTACWzLF7hyijQGBMz/pqvzIFnPINcEW2/XikCVWmBeM2BdIj7/eeyJt8qz1i+Je7RMINF9jv2d
 hGC97qMJ9YLY9g==
X-Received: by 2002:a17:903:3c24:b0:235:1b91:90a3 with SMTP id
 d9443c01a7336-2382409e13fmr55569615ad.7.1750858744522; 
 Wed, 25 Jun 2025 06:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe64AO2oDrZHSF9ZsGbKFmodoYYwqgklhSMYeMA9zOiVSN0aNTsecd2NAjWQ2kPh+jYJvzSQ==
X-Received: by 2002:a17:903:3c24:b0:235:1b91:90a3 with SMTP id
 d9443c01a7336-2382409e13fmr55569075ad.7.1750858743989; 
 Wed, 25 Jun 2025 06:39:03 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83970f3sm132638965ad.45.2025.06.25.06.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:39:03 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:38:59 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Mario Casquero <mcasquer@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 00/11] migration: Some enhancements and cleanups for
 10.1
Message-ID: <aFv789PcpagJfdJv@x1.local>
References: <20250613140801.474264-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

queued.


