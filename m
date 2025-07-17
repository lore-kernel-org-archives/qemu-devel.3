Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D66C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucQwe-00014H-HT; Thu, 17 Jul 2025 11:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucP2X-0007Yz-JO
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucP2U-0007rK-JE
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752760364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=W0kM3VdrSlmMNAElI2wK6+Py+7Gp4WHwNY9TodEvG+HsXK8m5EDs+L2m3taNGIBSRNG+a6
 PUX/p7ow2MHlk33L/TR0KU8/cdbyZv/MvsvXtJTBTg/pVD2r7WjsK+Nd9JtbNJytrv11ZW
 +TyZpPWzon+POkyXyT5wkBZiJZJBJhE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-dCObtnp8N6-xiWcc3_S-GQ-1; Thu, 17 Jul 2025 09:52:40 -0400
X-MC-Unique: dCObtnp8N6-xiWcc3_S-GQ-1
X-Mimecast-MFC-AGG-ID: dCObtnp8N6-xiWcc3_S-GQ_1752760359
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so4894175e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 06:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752760358; x=1753365158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DDr95+FiL3RJek2Saltsg6jHk1IAO/Mypi8s4NJB56kW/KfkVZVLBFYuPFut8lpZVZ
 YQF5nRitHSA/1nWk6BO+QZaKmCwwRXaWIo/nWuWkBoaud8ajIArICSDd33KjfgaaEfSo
 uQt1hTd97jq4Zw0J+oZpYSmb4kNFPeetOLqTn35maZtN3VLmcs21GsH6TQSLbtEZpE7+
 1BXNI88IdW9oD4pUnImQ7lr3iZ1ix59hhVj56yTgpdk7v07kRT2dxMSjpWBi6/1D0rKX
 6nj55kIm3cOQm+CBROZNkChjPIcaX7EdYaE4tVygCUP4YqKyiR7x2fc+m20QSBtTo3Ae
 oSHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXli3/Yo9XfYUEX9/iMzct1wle0pXX9QHMlgaeGr7/XzWbqtjPTIXED43+PPBrU2LO8dKBDeH32TbXt@nongnu.org
X-Gm-Message-State: AOJu0YxHjIYt5F0XxloLUaZa7cLJiEt5TIr02K5+7jpLc/i/uDSpXo6Y
 ZbjlQighaSg6dwJiF0DhRDqyGQSZyV5VyUhIv3e1NbkJYyYS+rCMsAQt3T5UBb5ZqQ3wp2Bqcyo
 A/paK1j6EU6XMcOjn8yZoMad9Y/3GJYL7523ovqK0wv8/raXQR8iWmVUHGrAOImo9
X-Gm-Gg: ASbGnctv+tISfOHnHAyDzGCxVW3JwNJkf2DO8nMrckpexc3LC3ts75LPrJd/N/8WujE
 DAFN+GT6tu0ZLjqcAF6YtLZBANd8T8BYsTC3ALoGR+jBbLYVuh4GlNnXX/mVJvY0/G+4Y+XaLRz
 fNQGVmMeZRs+NFDjFv6uIegyyeGOQzezlhiE8C4nxkpNAmThtLlt9oFNJ9zX5J32zE0W7oeRNQI
 DcK+aZpudFIpY5qU9n6IEhZMdYexGDVDhTiCpoOlF3sOIT8i71/26nguT38/zYBmQH+5smn3yGx
 4lwwydggPEVajqGDPszP61umc+o7EDOG5MzXRJYzANA=
X-Received: by 2002:a05:6000:18a9:b0:3a4:eef5:dece with SMTP id
 ffacd0b85a97d-3b613e983c9mr2603547f8f.35.1752760358673; 
 Thu, 17 Jul 2025 06:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcflhBrTtcvTxgMhE3Z9uUbV57naED4mC2Ah0N6RwLcZMH0zXWxf+j8fShzHI/CGvKJReKkQ==
X-Received: by 2002:a05:6000:18a9:b0:3a4:eef5:dece with SMTP id
 ffacd0b85a97d-3b613e983c9mr2603517f8f.35.1752760358191; 
 Thu, 17 Jul 2025 06:52:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21fdsm20768086f8f.33.2025.07.17.06.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 06:52:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Cleanup host_cpu_max_instance_init()
Date: Thu, 17 Jul 2025 15:52:36 +0200
Message-ID: <20250717135236.342881-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716063117.602050-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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


