Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D715CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKmD-0004Xx-0s; Thu, 18 Sep 2025 15:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzKmB-0004WU-E0
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 15:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzKm9-0007zn-KW
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 15:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758225519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZhJgUVOrIl/9LhFZvU5vWNCdAStYK7nWNGdsvwSJnMA=;
 b=S66qZ6HFX+3UcDJRpTWQO5GehqFN5QE1Fid2Bjcixt1krDLzP0nPpHT5N2R3601hIctMQm
 4hVhZfNBKWSxz5qlfjsausL+53D89iN3gFbVaRhgnJoXgfIxoyqTR3QtULihBEWUjg3QQv
 QoAErXdYHwlqaGoS+vo9g9u0M0cr0OY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-nB9VNObvNUmMjvPBRkzAow-1; Thu, 18 Sep 2025 15:58:38 -0400
X-MC-Unique: nB9VNObvNUmMjvPBRkzAow-1
X-Mimecast-MFC-AGG-ID: nB9VNObvNUmMjvPBRkzAow_1758225518
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b5e5f80723so24326591cf.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 12:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758225517; x=1758830317;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhJgUVOrIl/9LhFZvU5vWNCdAStYK7nWNGdsvwSJnMA=;
 b=xFaAByKsdzExzFPHrpyZSLQ74XNevJnMOMz/wxVHJNvfREYa7HVaG1qQ3g+RgXMmSk
 nR07RrPh5cI+2TKi+MvroVli8xXDzJlJ8cCPwoh+Ik21hJOa7YtyP2WNHPslWSm/DDNC
 +ISg3TEY5FrdVsJRM4jZoipMdvRsHzzJ21O2ODM8ornKfEwF4G2rOwaVy90KcWCDHdV0
 rNsgFNpS6VSOns3+25P2fFeh08VnJJ3/Dn+ua8XvQ2TTgXTw4pfsULLTcfIlCoC1cEHA
 MGAWG62o7tXibaLQCdInD+iu1elMQipMksPsWoNpfabVhlZ9u77Xad9ND3WraQUEUzP+
 E1GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2D6ZRzlrk6swMq0CKucwf73ozosAqXxqngJwW25JV+MaMRm07HCiIR8AqQ9zhU5jNdZxzsdoyMsA+@nongnu.org
X-Gm-Message-State: AOJu0YxB0kh/LIsqTzXLZ170FZmKo3l1dg0vD2GugU55PPHWDME817oz
 3FJEmyIOJ9i59fbTGEQAH7itweoooQDJod2VmAFC8AnwzUmE/JSJETq+wr/vP/bdy8Zu5HVUUrX
 9QBYd5qckMFT3jd6LdD0YLZr0nNaZHVn+OpJKgl8eBYAHlnKT7wJoYXGp
X-Gm-Gg: ASbGncsQKt7ukQmqFpSia7GzI7C6fcl2NOlYSML3gXcSnz8YCtU39j7SUhkOhNy0qAg
 w5oy9mdfZbAS8rs2ybnWjX3Y64F7useryH/ds5GQTGfXxEuS6ytdsmn5fLRirTC9/Uce7cPoEKM
 UAhSDIGVEKMxz+OFicDdgkkF2HeBYSKKORoDR4+iL36a/MBRJKJ5d3A3vPIihMmXxiz4EUw+baz
 HO7pCMLbB5PH9ihyIGeXOvwFq/g5T6bCQ7cGZcy5KSUyaJJF7+IpLTlB+oBLB304pfn6G5plLf1
 8JmeDzmVglFefnHroVNYflKaKmBfozeTc+SCSgJ+0PCqru358TmsD8QLfjK5EydnFTDOIy97HtZ
 LJwJ4KpmgVcfLcqkDZUApFQ==
X-Received: by 2002:ac8:6f15:0:b0:4b7:9aea:1a0d with SMTP id
 d75a77b69052e-4c0755a38cdmr6897101cf.76.1758225517464; 
 Thu, 18 Sep 2025 12:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2L65vYNy7m4Z+UcdbfZGg3yWRQ/fGOSzmRN1Yhv/tl482ETUqjK3x9J9txcg/04v64li47Q==
X-Received: by 2002:ac8:6f15:0:b0:4b7:9aea:1a0d with SMTP id
 d75a77b69052e-4c0755a38cdmr6896771cf.76.1758225516835; 
 Thu, 18 Sep 2025 12:58:36 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bdaa0c5156sm18265951cf.45.2025.09.18.12.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 12:58:36 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:58:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
Message-ID: <aMxkaLbykwqD1yHn@x1.local>
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <aMqiK5SaeBJlSa_h@redhat.com>
 <a1ad2a8f-8a69-4d25-bffd-482aec2fe9db@rsg.ci.i.u-tokyo.ac.jp>
 <aMq073aYphuFO2En@redhat.com> <aMq2V0rD2Q27VXOg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMq2V0rD2Q27VXOg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 17, 2025 at 02:23:35PM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 17, 2025 at 02:17:35PM +0100, Daniel P. Berrangé wrote:
> > On Wed, Sep 17, 2025 at 09:24:04PM +0900, Akihiko Odaki wrote:
> > > On 2025/09/17 20:57, Daniel P. Berrangé wrote:
> > > > On Wed, Sep 17, 2025 at 07:13:25PM +0900, Akihiko Odaki wrote:
> > > > > Based-on: <cover.1751493467.git.balaton@eik.bme.hu>
> > > > > ("[PATCH v2 00/14] hw/pci-host/raven clean ups")
> > > > > 
> > > > > Supersedes: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
> > > > > ("[PATCH] docs/devel: Prohibit calling object_unparent() for memory region")
> > > > > 
> > > > > Children are automatically unparented so manually unparenting is
> > > > > unnecessary.
> > > > 
> > > > Where is automatic unparenting you're referring to being done ?
> > > > 
> > > > > Worse, automatic unparenting happens before the instance_finalize()
> > > > > callback of the parent gets called, so object_unparent() calls in
> > > > > the callback will refer to objects that are already unparented, which
> > > > > is semantically incorrect.
> > > > 
> > > > IIUC, object_property_add_child will acquire a reference on
> > > > the child, and object_property_del_child (and thus
> > > > object_unparent) will release that reference.
> > > > 
> > > > The 'object_finalize' method, and thus 'instance_finalize'
> > > > callback, won't be invoked until the last reference is
> > > > dropped on the object in question.
> > > > 
> > > > IOW, it should be impossible for 'object_finalize' to ever
> > > > run, as long as the child has a parent set.
> > > > 
> > > > So if we're in the 'finalize' then 'object_unparent' must
> > > > be a no-op as the child must already have no references
> > > > held and thus no parent.
> > > > 
> > > > IOW, the reason to remove 'object_unparent' calls from
> > > > finalize is surely because they do nothing at all,
> > > > rather than this talk about callbacks being run at the
> > > > wrong time ?
> > > 
> > > This patch series deals with the situation where the parent calls
> > > object_unparent() in its instance_finalize() callback. The process of
> > > finalization looks like as follows:
> > > 
> > > 1. The parent's reference count reaches to zero. Please note that there can
> > > be remaining children that are referenced by the parent at this point.
> > > 
> > > 2. object_finalize() is called.
> > > 
> > > 2a. object_property_del_all() is called and the parent releases references
> > > to its children. This is what I referred as "automatic unparenting". The
> > > children without any other references will be finalized here.
> > > 
> > > 2b. instance_finalize() is called. Past children may be already finalized,
> > > and calling object_unparent() here will cause dereferencing finalized
> > > objects in that case, which should be avoided.
> > 
> > Oh, so these object_unparent calls run by the parent, against the child
> > in fact use-after-free flaws.
> 
> Oh actually not a use-after-free since memory regions aren't directly
> freed by object_finalize.

We discussed this previously, I think so far it's 100% safe to call
object_unparent() twice, because step (2a) will reset child->parent=NULL.
Then at (2b) calling object_unparent() will be 100% safe because it's no-op
for an object that is orphaned.

So the series looks good, but it's kind of a cleanup, as object_unparent()
is just unnecessary for these MRs, same to the memory.rst doc suggestions
which can be avoided.

Thanks,

-- 
Peter Xu


