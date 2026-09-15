Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD4FC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WZT-0003hd-PA; Tue, 15 Sep 2026 13:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WYc-0003UG-Pv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WYa-0001vA-Fj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789491773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efQn69+aIitCgUXrQDQSZ250W0uOnQnFUdUd6C1cc3c=;
 b=h6nH+FdcFpFoOhCGEu+HmSZMJUk1EbZkosa4PPPgG6LmVUeGToqiQkWBNI4BwSC3GG831Q
 Wxijpg9AXuOa/JqxRFL5dtPm7MlHMrzROzdL8M8hVGJCw/eemQ4UhG4mjfLaB46cy6K7l6
 Z7nU3VD6KbEP2jGBWi32Kg4DPQjaCOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-yQUZ0cM-PFyAPZKiyTBRMw-1; Tue, 15 Sep 2026 13:02:52 -0400
X-MC-Unique: yQUZ0cM-PFyAPZKiyTBRMw-1
X-Mimecast-MFC-AGG-ID: yQUZ0cM-PFyAPZKiyTBRMw_1789491771
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6c17ec1dso37470965e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789491771; x=1790096571; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=efQn69+aIitCgUXrQDQSZ250W0uOnQnFUdUd6C1cc3c=;
 b=etTs/EnGUwt8CDiLh/FrK1LRcYIevpFVc2cePegwALg+SgbjIOMTqLiWgdChvXPDlg
 05t3Vuf78P0tedSCB7CrmnzRkYqrHFmUZXAKdpcSfZlP9Sxj8DZuDxl7AM/IaQmtJGTK
 zKq7I4iVhfzFWP1ofB+uW5xsCP8izgPHvmWFV+uBNk7HVw1OmwILC6ikpI6EpSexZBZb
 6yNsPGtcBQwVVjfTSGpYwwlgY9cpCCs9BVKUOXqBz1Aho2Wo46ySrNMskf5gF1u/qbGz
 bJ1U+AogvOwWpS8Z5HFotnkiqR+lrMOvsh0fFEW0QsdUxlHskrt7Js9e0VmwNExk1LP+
 RkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491771; x=1790096571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=efQn69+aIitCgUXrQDQSZ250W0uOnQnFUdUd6C1cc3c=;
 b=tFjC0VFrzoOLcOqOZc1PwV3meKRzoseDb9LbTixA4WfOfFtsMxVcWASyX6nOnPk693
 e/U9AJnr1vghwGLXzGFk9FegfP/3Hf1nV43GNeDSIkGo87Sdn2nOpZB+16nR4DSPSAYq
 +beyEkCOzzPDOe9srYtpL+ImrJn5n55v8+q1DRvLdwlggl5MtTj1Xzdu72vTH6BCfxyg
 eqOwXjxKqNfCzKbtgBeA/lC0qNPAJkmq6UbHnARuxTP5lV5UYzDq5wVQ/HthGRrgQiky
 2JVp+YvqYhwQIuPx/RsKzlXV+oGjIfC2CC+u8obPBrhgVIML6Dds2O5DYvLS+BYJpJGj
 fUmw==
X-Forwarded-Encrypted: i=1;
 AKwUvByu8y1PGpjXYlpS/P7Ys90EdwE87ekURNgpQnHe80oYc5de/aWi99jvxdIQwRV1DraxXofTPaovzFbq@nongnu.org
X-Gm-Message-State: AFuF++njc7wEhb5zDpGNY9VPP5nQWGse4FbMVe9TrLSbNsX/MGFE1oF2
 rz7izr0WZqur78DUDkC0aaDapwCVI7v4cgVRMC1JclFwrSbLCsWiNRln4Z9cTCayQ6tY3z3BXFq
 nLouBvvB95jYnsgYWGgd+YLK46t0n9DvyRjMRdYNpsv2N9moSMFI6T/HR
X-Gm-Gg: AYBFou0cgEd8yfn+d2KjDuh01ecAu+Zq1sPyqV9G3rSEqhwpW/v0wlYmkSaCCHg0i8v
 gTugxRvr6C3P1wxe34rYI0sJCmeDPCPcN3CU8w+35CGRTErGF5W1UaV83yfAiOuxENKghgzK+Ri
 tQP2LJL0ZOKpTScbaa5rbXAwnKaU5wW//5Rij76aoeRT/NdHrqonTIg7xQpZYcTeVg2iffS6jVs
 Th1cyweRbt8GBr1x2gp8Ps05Ws8pb4JsxHLeYaSVYROTsHN1hYYBL5c0wXqc/j821iZJFixvlFW
 X4JNnvoTWEF3MpBspaELs50WY2mPqSCidtFjcV2O+SdXBhcfTAGj3p1itT2gDook5zRTqPZW4PF
 ME402Ku6C5D2sZUrES3Zjp94=
X-Received: by 2002:a05:6000:4545:b0:487:350:59d0 with SMTP id
 ffacd0b85a97d-48703505a04mr13542014f8f.6.1789491770578; 
 Tue, 15 Sep 2026 10:02:50 -0700 (PDT)
X-Received: by 2002:a05:6000:4545:b0:487:350:59d0 with SMTP id
 ffacd0b85a97d-48703505a04mr13541946f8f.6.1789491770112; 
 Tue, 15 Sep 2026 10:02:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fad3sm325828f8f.12.2026.09.15.10.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:02:49 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:02:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, stefanha@redhat.com,
 kwolf@redhat.com, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: PATCH] hw/s390x/s390-hypercall: fix potential NULL dereference
 in handle_virtio_ccw_notify
Message-ID: <20260915130139-mutt-send-email-mst@kernel.org>
References: <13ad0871-44dd-40eb-aad1-d08cc2d7dfe5@swemel.ru>
 <597e1a7a-8720-4356-91ed-a7c9fa416312@redhat.com>
 <1749cad8-1651-4543-8a2b-aad3c1168328@swemel.ru>
 <5673b15b-22fb-474d-b3c4-89f9c3c0c8c6@redhat.com>
 <6bcce310-9ac7-4e08-9932-69277127636e@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bcce310-9ac7-4e08-9932-69277127636e@swemel.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 15, 2026 at 08:00:45PM +0300, Николай Зорин wrote:
> not AI, only (empty) brain :)
> 
> ok.

I'm not saying the changes are bad as such. They just seem to need
more work, such as reproducing the issue and testing the fix.
Or maybe this was done, just not documented.

-- 
MST


