Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7293FC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taEWF-0007Md-4w; Tue, 21 Jan 2025 08:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taEWB-0007ME-K1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:42:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taEWA-0005SW-6m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737466929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1Q0VoFSrJntrm+ixE/PmRZGLWS3C6/Mi6nmNcAEzs8=;
 b=bDmZKzIpnsPJu33mxP+PYthUI2bD4LQFq0jLoW33r0qGdJkAFEneAddi5Rm4lwYh3XSjEp
 vn1uBAjpXhydiaOLCKQW3k61juqOtNvMwFscciIm3ypmyahZvf7ZhMy8x0KHHLhCA6L3Um
 E1k8SZpoyeyEaZhjPZNri1S+XQUBZZs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-L0eRR6lVOLGNX2d49Rm0Uw-1; Tue, 21 Jan 2025 08:42:07 -0500
X-MC-Unique: L0eRR6lVOLGNX2d49Rm0Uw-1
X-Mimecast-MFC-AGG-ID: L0eRR6lVOLGNX2d49Rm0Uw
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d3bf8874dbso7975796a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737466926; x=1738071726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1Q0VoFSrJntrm+ixE/PmRZGLWS3C6/Mi6nmNcAEzs8=;
 b=ECg4EEjEsg/iYpqwWexGuEmKiao8JlB7Zt3I3iS5QNDHRW5w7KrQKcZAzaxMM03K0L
 rLHLtjBtW8+djrLnxJOYs5xpf18/zJ3iucVSGal+TqINbva5oNN1d9Cg37pJYmd6edRT
 aMPceu9oUM+8IvGTpOtLLkTntHSAxnzknqMd8b2GXx/7U7zAiGm/UA8mSEyHIKHoWNKh
 D+vMLhw7Rr0GT+BfeiC+nV+ZOaGIJqySn7t46N0WzOGQuC7H9rPLyGa6/tUStvjk0ahb
 xdVn0ID6GuY9Vwv+R9uROY0uS69JpUkDKaxs5QBYnI5l/pDQJrsM54SuaNLeCl2ZySkW
 E6YQ==
X-Gm-Message-State: AOJu0Yzd3ASFNgPW+xi/F9nkxv4TN+fYazs9a7KADgkeuduXdPyGUNWl
 4kvAs0vLMY0YZsK9VMtflwP67YnO4QdKLq6HXiOKM9mahkVaLiXmH5/ZV6CStAwXRk3QQ3neaq9
 TOduOXc16S3LyKjlYm5aI4O8IcqQorX8Jike5KiKZhi3X4FCXLtWHH/dw+auOpUg=
X-Gm-Gg: ASbGncukaFEqht0GeRdhYfQ7rzNK8l+zK8erW3TD+UJrC/GEBYDkQ9LGrk4FTf2mK2D
 IaFMFDbHTdbNPJ6NR4t7j2IVtfPeN+yUPHQw34hewpHpuhGHOFFRQrn1X2gKbAM+8ufkJeTKZDk
 b8NVMD9fFeiU4swWmEek6i4lrUz2+w9NYfbYPA0J55jg1Ex6Fg+bzLHEGkAV6iRwiIIiQD5i5G9
 sLJbfTVaDvr4Z+a2ThpBDKYBEyBKMhkuRwSOAf1BLO7YbE4xKn6EWwElBgjPmf565F/pl4nY38=
X-Received: by 2002:a17:906:3a87:b0:ab3:a190:6cb2 with SMTP id
 a640c23a62f3a-ab3a1906e5cmr1131625866b.25.1737466925781; 
 Tue, 21 Jan 2025 05:42:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJXT9QREep+HI9y53zPsvjNU5rQoZTTZMAnPCZ+W7JlmSssr6NG2W9ym00HyHTnuHOUBvuqg==
X-Received: by 2002:a17:906:3a87:b0:ab3:a190:6cb2 with SMTP id
 a640c23a62f3a-ab3a1906e5cmr1131624966b.25.1737466925406; 
 Tue, 21 Jan 2025 05:42:05 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce1f1asm763787066b.58.2025.01.21.05.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 05:42:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 0/4] Introduce SierraForest-v2 and ClearwaterForest CPU
 model
Date: Tue, 21 Jan 2025 14:38:44 +0100
Message-ID: <20250121133843.2112669-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121020650.1899618-1-tao1.su@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

Queued with the tweaks suggested by Zoltan and Zhao; thanks!

Paolo


