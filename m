Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3789ACAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFFU-00014D-FB; Thu, 18 Sep 2025 10:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzFFB-00013i-08
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzFF8-0006tu-5E
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758204252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oylp830QgzWCxYygQPu4YXMnJbTIkCEHwCADQS7PoK8=;
 b=gb8YW2X6GyTHcq1cYm9jVcVGeCa+yqlAiKn/xqomi54Dxmk2yuoFbKTY0wwBOSLxuH70Ac
 tlCSUPlWjhMLfhXDDS90e9EFeRdEuPl1TkJ8DPyO8aWB6SNR/IY1MxJtw9Cw1qH4dHr4lB
 7g1NuEAFfVsU0fkegsC4Z/K8+ANvC88=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-lt1yfbiaOeiYBM5RwOtACQ-1; Thu, 18 Sep 2025 10:04:09 -0400
X-MC-Unique: lt1yfbiaOeiYBM5RwOtACQ-1
X-Mimecast-MFC-AGG-ID: lt1yfbiaOeiYBM5RwOtACQ_1758204249
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-806f812a0aaso206442485a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 07:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758204249; x=1758809049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oylp830QgzWCxYygQPu4YXMnJbTIkCEHwCADQS7PoK8=;
 b=iYnOYuTYJQ0uDYx00vPWNUvf1F8La37F72WV3EDErRRQ8KNq9LxLJnYFSqlAos6bGs
 V/GcFjSG9+kCdjErLmtd/ohSdb0FdJppIs7HIr9j9Jo8XiPamjs7n8zCTD/OR9lRsx4u
 8BEtFQP9K/8jOrYwPyQC6ZCokIZTdgWceOWmP6NP1sA5hOq+QhtxQMCN5dxgCa41bcQz
 wiEvTfMLlF5P6lMtQ03cWKMMkZt/o5SzEa0RoG+uTd1pke0pU5awFiojm0DFQ+r9Fgb4
 c+3335ubUtM05Mr+o237WhUQrgm2x2PKbymaFw7eN8E+jYVtui1khfGA95ZVObdsDHcN
 Jy7A==
X-Gm-Message-State: AOJu0YwWfqg4bO5EkmJccwwbLlO1x1x10aOQSHqcOcXWLccRjOEHHPwX
 6p40bSSPja4SIb9FwK1I0pYlF9n77nehOBOr+Tq+ZKnsbTmjzRHOb/bs15guDK7cJGGOu7e06Zt
 1ODBT48KAiNA1TiIr41jhDjozIar4S1dmZrfSpoWL9+RfW71/UGxDhC5M
X-Gm-Gg: ASbGncswKl+FP+jVC1sOEBYbokUx1h5VbZERDLgh5j5gIqU8a2VY3onOowCKPwuOQ4r
 0M5Q/H68H2If0OqxeZ74zfDkYYiWE291mEHZ1c/q5x9o55zw5BWUawnSGRaQxAAsmIeCvwzah15
 z0NHoIVgsZnqRuCSjiyBfaCQVomk5flgElR8hMkOHNPXOuRtyXI1ho5Y/3C++CL9vwfqc5A1jzH
 H9IWNn+B6y/jfMf1ipAK96uAXGmoF4SGJJ1wfjrDyhhyLoDajHzCVsBSvgJxpQlpHzXuCnMCO2Q
 Be/VPfBA6nqWGbzKcxg4/CDiozG6ZfE9
X-Received: by 2002:a05:620a:2a07:b0:822:f45b:a5ef with SMTP id
 af79cd13be357-8310a6416admr643807185a.29.1758204249134; 
 Thu, 18 Sep 2025 07:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa8HlWVxiunhxh9YQWqVYN7oHdznhotjK4AQbo42C9SFdIf9dV/mPRmaLtfzCAOkZHoqjgOw==
X-Received: by 2002:a05:620a:2a07:b0:822:f45b:a5ef with SMTP id
 af79cd13be357-8310a6416admr643799885a.29.1758204248504; 
 Thu, 18 Sep 2025 07:04:08 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8363344e970sm165242485a.61.2025.09.18.07.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 07:04:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:03:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/7] Do not unparent in instance_finalize()
Message-ID: <aMwRSpezxmIwIHrU@x1.local>
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 07:13:25PM +0900, Akihiko Odaki wrote:
> Based-on: <cover.1751493467.git.balaton@eik.bme.hu>
> ("[PATCH v2 00/14] hw/pci-host/raven clean ups")

Could I ask why this is a dependency?

-- 
Peter Xu


