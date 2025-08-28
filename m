Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041FCC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgGa-00040m-HQ; Thu, 28 Aug 2025 13:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urfD5-0004OA-Sp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 12:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urfCv-0007A2-Hd
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 12:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756397433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDERzEzBHnJXU1xhba4X/mrF4LFYKd9iDT3MmhX+84o=;
 b=SKdL97E+z95ZcPLm1n1PS7jFIYCpoXR7CcYkswUicxCom2ZwIAsjlSH1giGHIdzr20ARft
 xa1BptCWJ5oCYX2LpHt/+vJZPKyozBNCdEHkKZWLgRWs80oW4OO1Zp48QjRlQ4On/+7LCH
 rB9exq2KpRpOcswMdjO4FGKgedsBvr4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-fE-B3N9kN2Wpl0FQnED6pg-1; Thu, 28 Aug 2025 12:10:31 -0400
X-MC-Unique: fE-B3N9kN2Wpl0FQnED6pg-1
X-Mimecast-MFC-AGG-ID: fE-B3N9kN2Wpl0FQnED6pg_1756397431
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7200579b490so14704727b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 09:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756397431; x=1757002231;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oDERzEzBHnJXU1xhba4X/mrF4LFYKd9iDT3MmhX+84o=;
 b=JVjTkR4HUP4+KqrMt3m/PV5RcfMVvAT0X0bJV7qM1SZYjxA2pv35V22oBzuMYc/4mJ
 lNdYGOuPQ+JCYSFPmACRTAtHAFzzgZTyUzieouw03xyY9VrXZPsAQK6RAG0JQN6mHhcH
 uZYdvbLQG2/LrZmry0pLszEuN+2esr9kq1bJd/FcH90lu9ydXLrMHsPI2gnP3UWG7zEu
 Q0eQuofsAJ85otCKV+Chs+jNLcj0eiN0+awBE29a4skVMClv7QPJFW31xJf5bsYrndZQ
 4OVo/oyHVdZv7pRgwfvVxxegK9gQXtqF8U1gT1fSV8rcf+G6LFcADdgayNUn11+1W2v1
 shSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd7ub6zYWjk2D/cgk+yZWJkwLLctLD+Ll7+ApiQ+pUFbvgQ5ea4PTiXLhwKC2Cubd1AlrpqSwixdEG@nongnu.org
X-Gm-Message-State: AOJu0Yz0izNgt8RZGOhORyIupCFcXyrlxGwEAkcCzPD1cGrCugKhSCkk
 kF/X7RQjvN/FTwdRtboapwg9lBeJnoETfHWMksvw6iTMizxEc697z4B9UXbXu24AOdIeCholfKf
 1Hc6D+Cd85GJdPFwKXsiI2dj6A4TqnAeLo1BN9NgP2YtT7p5dyfnzAYvI
X-Gm-Gg: ASbGncvcL8aFIAq3ljuFPIWy6oedS1Z4qHgK/QyMNqVTTnIZVZJCWk1+m0capDDOjQT
 p3NHqHgJhm9Xw9V8bCRlQDY+uypr8UbIxiHRKv+ciOK9xWrOriv9+OZ2sbKAY1es+h5XUC0PSyK
 FcA+eEvI7URFr2pIWvMfxpqtjlNr4DgHwI+mlaDDcjFWDXqzzuzITDr/5lBoLZrTkHSwx90vrIt
 zxq6GvDkcW3QiecBPUMioXiaFQ5qDBOwQWNxl4qrLca4BHYHxacJY3QSnnReM8KjGhIlTnrSy0D
 zo3n2nNHe2AOOPHh9JUtKBgog6HHiZ4Q
X-Received: by 2002:a05:690c:7401:b0:71e:7907:7b49 with SMTP id
 00721157ae682-71fdc2ea7demr274947887b3.14.1756397431199; 
 Thu, 28 Aug 2025 09:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuYExElLnfjtVRrMpzw+tR5E8Ja0u2iCfHxqP09K3DJkDuValsY2MLsWzGKlYAAccsX0Sjuw==
X-Received: by 2002:a05:690c:7401:b0:71e:7907:7b49 with SMTP id
 00721157ae682-71fdc2ea7demr274946897b3.14.1756397429998; 
 Thu, 28 Aug 2025 09:10:29 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-721c634bb45sm353257b3.22.2025.08.28.09.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 09:10:29 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:10:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <aLB_ZwL7v9Uzvc2s@x1.local>
References: <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
 <Z4a3GxEbz1jjCDc5@x1n>
 <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
 <d9acf231-829e-4a9c-7429-282fcc2ae756@eik.bme.hu>
 <2fe8b128-dda1-40af-89ac-e86ba53138f5@daynix.com>
 <CAFEAcA8A97ocOfv72KeSEgFkchmAOfc=GiX8QmvRui5=DDF=qQ@mail.gmail.com>
 <878qj3zitv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qj3zitv.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Aug 28, 2025 at 02:17:32PM +0100, Alex Bennée wrote:
> The virtio-gpu blobs are a special MR which we handle clumsily at the
> moment as they are backed by separate thread (virglrenderer) and we need
> to jump through hoops (c.f. virtio_gpu_virgl_hostmem_region_free) to
> make sure it is done with the memory before we can free the container.

I remember looking at that path when discussing this problem.

Using virtio_gpu_virgl_hostmem_region_free overwrites the object->free is
pretty tricky.  Same on having MR->owner points to itself..

Is it possible to make virtio_gpu_virgl_hostmem_region an object, then make
it as the owner of virtio_gpu_virgl_hostmem_region.mr?

In general, whenever a MR needs serious refcounts on its own besides the
device to be emulated, IMHO the simplest way (which still 100% follow the
current QEMU's MR refcount design), is to create an umbrella object, making
that to be the owner instead.

We recently also have another discussion on how to achieve similar dynamic
MRs in vhost-user's SHMEM_MAP series:

https://lore.kernel.org/all/20250805081123.137064-1-aesteve@redhat.com/#r

Ultimately, Albert went on with the VhostUserShmemObject approach, looks
like it works all fine, it's used in his latest post:

https://lore.kernel.org/all/20250818100353.1560655-2-aesteve@redhat.com/#t

In that work, TYPE_VHOST_USER_SHMEM_OBJECT still dynamically allocates the
MR, but then it needs an explicit object_unparent() in finalize().  IIUC it
can be an embeded MR inside the owner object then object_unparent() isn't
needed either.

I may not have the full picture of virgl here, but not sure if this can be
solved in the similiar way to avoid the hacks.

-- 
Peter Xu


