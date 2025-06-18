Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8886C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 22:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS1Aq-0007cY-Hq; Wed, 18 Jun 2025 18:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uS1An-0007cN-HC
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 18:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uS1Ak-0004Q6-17
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 18:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750285338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvdbqMvmqccHbDYi1u6MCaoXXJjQgBtiZn30PfS8Ulc=;
 b=hDE0ocPpHXxxrdX74wFF1/NDmgkmV50CYM89DKf3HmfyRyOu6C4INQfIW/LAYwJIYWwHvC
 HDzSh40Ql7XN2Yx2f2GZrnyRlNHn4my+h/HWu+cYQkgFNNhiRCyRZqOoPEG+F+QxYwUCvz
 aRFvOvnA4hXj4Rc4OjiyWeuxe3fO3p4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-eUwpKFq7OEuCg0dd7RPVjQ-1; Wed, 18 Jun 2025 18:22:15 -0400
X-MC-Unique: eUwpKFq7OEuCg0dd7RPVjQ-1
X-Mimecast-MFC-AGG-ID: eUwpKFq7OEuCg0dd7RPVjQ_1750285334
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b16b35ea570so212733a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 15:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750285334; x=1750890134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvdbqMvmqccHbDYi1u6MCaoXXJjQgBtiZn30PfS8Ulc=;
 b=mf/Qm4PWsC9/zoFjzhBEHBYq6KNkMg3FUWvtyBw9aMV4dO5JJGBascZzFuQ8mVDdmq
 76YSiVHMuZq3lQbiACrsKl8dFt3F1eACilcED/nBYMHEEqw1W65JsSq5Gk0eTgJXhXPB
 u+GS8vxBhq3Vr6j0xDmtZCDNm9K6JqVVZk2luSQlvg7DeCS/safdIbsrNJSkOWop9FmQ
 QMCXNqLqwzNfJfFg7OcE9EW/S7lC0au3vJ2COAkizayyt2YgLtRtbGO5oB8qUWjNAtrc
 biRRyQTOai7GAKZe0dfCKnD517rg8TQ6AvMbwp4Jqidl6qoWmrNthDzIhs6Uzck3e267
 Du8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/z24lawykpt6QTIgLb7/i3JAy8QiVgvkMJ9dxYKWJlrmw1V3U94wsTcdogy3wp+ikdaUaGwoCA6PE@nongnu.org
X-Gm-Message-State: AOJu0YwNKJJZNzeSwpEs1HddLsUIcCStTgRNt74irSd7K6+NOfILhWpX
 8WiIMoTJ3MQ3/+7DL6SBv13RanvSGZmg+gPT8MSKSaikXgrWzqsLfYjQKydQJ82qMJGUzk355l0
 Iolb8fIt9EjyrcbTxrslNha8wBCEy7uLuEL9fTFvuMDAHsGOpnwvHUmbt
X-Gm-Gg: ASbGnct6JTZXCFJN/n1Kzfjc6NQpVqrccPoRG81kDVoVui/+qp+j+dentWKhWx0lMe4
 XLdsQL9t9pwIb4gm4i0rMgeU4yGc5DpWD5j5f2Fse/WcUgKXogJVR6ReQ7O5kf2ZBNfj8U95GUz
 EV5o5NsOhLF7ykNLLccSESS/1MA5pwSiSEXq1brTXd7mz0fdUmoLbw0SXAsPThLoyKNuYM8fTr2
 dJRUVrv3D/wxDm8eys8MyXwCaZlhSNKvuvKNMjTZEYVi+eqwnqgeYPi01QcUkK3KeaI7zgt1Nov
 2ooKYJCuMCTZ5w==
X-Received: by 2002:a05:6a20:3ca7:b0:1f5:9024:324f with SMTP id
 adf61e73a8af0-21fbd690f1fmr30913423637.31.1750285334416; 
 Wed, 18 Jun 2025 15:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVnjorF2p/TsyHRfQO+O89iwaSTCUkL5cFkuUmViiWGO926kqlUR1fIZpNOQWV8GOC1c5Wrw==
X-Received: by 2002:a05:6a20:3ca7:b0:1f5:9024:324f with SMTP id
 adf61e73a8af0-21fbd690f1fmr30913389637.31.1750285334067; 
 Wed, 18 Jun 2025 15:22:14 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe1639eb8sm9832380a12.10.2025.06.18.15.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 15:22:13 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:22:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 0/5] Enable shared device assignment
Message-ID: <aFM8D7mE2PrVTcnl@x1.local>
References: <20250612082747.51539-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250612082747.51539-1-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jun 12, 2025 at 04:27:41PM +0800, Chenyi Qiang wrote:
> This is the v7 series of the shared device assignment support.

Building doc fails, see:

  https://gitlab.com/peterx/qemu/-/jobs/10396029551

You should be able to reproduce with --enable-docs.  I think you need to
follow the rest with kernel-doc format.

If you want, you can provide "git --fixup" appended to the reply (one fixup
for each patch that needs fixing) to avoid a full repost.

Thanks,

-- 
Peter Xu


