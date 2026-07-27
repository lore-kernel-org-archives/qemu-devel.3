Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6167EC531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMGv-0005Dx-GB; Mon, 27 Jul 2026 10:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woMGT-00055H-BF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woMGR-0001YS-G5
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785162306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7VzblEml9Z5dIxjHzOxhK5vkTx7quxbYMHxe0etLbE=;
 b=XiTvM3vigNnovlCb2ggikC8XfOL7GCDEzImM9S1u/82VZIln9quohuRFlfl7taNremhVRV
 sZNqNywSXJb8jrKLwRgBOb4kpB2CqEYKC4QTzXi/M8YSuebwwZLHbt2AJzCybbN4ksMVTi
 /6lXRcpVf8h0+AvSg1OUHxUR/vYjoyQ=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-tEPbbAuaMTWId3HaaOmHig-1; Mon, 27 Jul 2026 10:25:05 -0400
X-MC-Unique: tEPbbAuaMTWId3HaaOmHig-1
X-Mimecast-MFC-AGG-ID: tEPbbAuaMTWId3HaaOmHig_1785162304
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9772fe08326so1970081241.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785162304; x=1785767104; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H7VzblEml9Z5dIxjHzOxhK5vkTx7quxbYMHxe0etLbE=;
 b=kR0VmNuZvO2J6TnXpylDsfkErXGCI5PADmCqn/20CgTXibYsLzvRxpFdcUsWFuz0iR
 NCxnpKM0wVbDp8gYNotjHc8fyyDjaCVF/iH3Sssk4ve02zjs7QVl+ha3TTxTU+mVvQY5
 Ugde5aBw5VJjtY2PfKVCBZ3yjOG4zzCk8qKwYeeavuBWETtWOFFDEL8XTm1vkYSG2nPu
 ZJlcR6HG4w0U6XtdgFyTPKsMj3VHJne3/gBeDNyi7T4CFZZND1TvCaWjhECcOLh3Syhp
 7ywyUmmzHbmzqj+O/0gYiFxAPD/ubDNnbJTAsugRXFkC3cwNN8ySZMPO1vPRxZYxrK2h
 R+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785162304; x=1785767104;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H7VzblEml9Z5dIxjHzOxhK5vkTx7quxbYMHxe0etLbE=;
 b=OOFgXDlWUUKhgvj8/3P/2EULxfLQIXfXwGBkzNOl9mzqyKsq6MjPHUovORVpmIG9tF
 PxnYCyZ3d0DI4peBYrx5y8JATmqCQrJHKrsGAqqh3XhjylQGlWxD5sXzzRVWbO5tv4XM
 C+3wg7G0FlMUlsiRCbjwXALJ3VvkWuD04WhYd4yCQqhjY2ch8MFEZDVwlGUK++dagXDx
 /7ScmJGwItFMSABNqNF3QbbIxCCo7oDuQJlok6OEFAiHJWyG2J0TGCsa67DXXdy+4svn
 1Wvu2i7x8YAdb4Wjhgoka3g2gIDti+4AFqVYQ4b1HTdGz/0pykSgK0FhNiLS/ZxDsYOy
 Usng==
X-Gm-Message-State: AOJu0YyeZv6j/4d9rnOUoR4z8P4PktZ49BEp6W3ED+Hrb9/0ou/QeX6S
 Kxr1wCRVSggoNlhTlvPrna7BGmdIMFB8jwj/OElszfqmxVy/4H1w/RMv9s8JnnOTnETRmcKC3G4
 0UayRimK496BjmR8ze++4l9JL8XAb0QypdpFpHEEK6DTZGzB9kT06w9/2
X-Gm-Gg: AR+sD13fybetKYlJzvituyRNeUkJp4YpJ/sI8xF3fau1t8ti0TREuT5KUFg7sJQglpp
 XOeBTuxGb0iPBPZk203uMH4MvhMpxK1Zyw4K3GCOIIsROU0qngAiXys9hYm6LvP0oDT2yJP+HdV
 k0g+sqw3HAAo5reO15gmvSg0Q/gLB06blx8TPzmHTF9Qr69ge4uMytKbmPczKWeKPueMbqMPIDH
 TQPDwoGk9zC7BSMA5DfZIYpkmSldX394u/kXiDjG61RTDdVdouHJr+4Folbz44L5rXH2IqvkpRD
 FUZqUC+Yaj79zdWUYfC4L78g0JTeLWSEXM4kVLYtOy3W2+iZJuWXEZtpXuJkil0pW2vGmgDs
X-Received: by 2002:a05:6102:2150:b0:74c:8ba2:3e90 with SMTP id
 ada2fe7eead31-74f9d08d0a9mr4042719137.3.1785162304332; 
 Mon, 27 Jul 2026 07:25:04 -0700 (PDT)
X-Received: by 2002:a05:6102:2150:b0:74c:8ba2:3e90 with SMTP id
 ada2fe7eead31-74f9d08d0a9mr4042686137.3.1785162303735; 
 Mon, 27 Jul 2026 07:25:03 -0700 (PDT)
Received: from x1.local ([2605:8d80:6c21:6818:c87e:c65f:8297:5636])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-75033d6a692sm5507243137.1.2026.07.27.07.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:25:03 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:24:59 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 11/12] migration/multifd: fix Error leak in
 multifd_recv_terminate_threads()
Message-ID: <amdqOwtJi-6UTbgw@x1.local>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Mon, Jul 27, 2026 at 12:44:10AM +0400, Marc-André Lureau wrote:
> If err != NULL, free it.
> 
> Fixes: 11dd7be57524 ("migration/multifd: Remove p->quit from recv side")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


