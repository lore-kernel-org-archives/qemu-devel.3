Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA92C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJA4-0004M6-U4; Mon, 27 Jul 2026 07:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woJ9v-0004KX-IT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woJ9t-0005aA-H9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785150367;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R16KcF6eEceIJ47/T/uJgZYu0MqYFlFXA4N2MOKufh8=;
 b=V6Z9eBK+B0d0oIl6/98vn/7uowYgbtGdUSjw+9W8obVNFujAQ4Ioi+gItLYDavB9egYyVx
 7h2MRKEyN/gH6EruumqZ0hrjSz9KVwIBDRWtJ+XatfB6CaAGd5nd7TgvfTH+ypAf8Req68
 /UQEG8M5dvoH5z7sjPFLSQz/XXcmXe4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-Vb8SiA_EMquHF2lWt_7PpA-1; Mon,
 27 Jul 2026 07:06:04 -0400
X-MC-Unique: Vb8SiA_EMquHF2lWt_7PpA-1
X-Mimecast-MFC-AGG-ID: Vb8SiA_EMquHF2lWt_7PpA_1785150361
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D7671955F6F; Mon, 27 Jul 2026 11:06:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCD025AA; Mon, 27 Jul 2026 11:05:51 +0000 (UTC)
Date: Mon, 27 Jul 2026 12:05:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset
 info response
Message-ID: <amc7i7-2N5fgXt39@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jul 26, 2026 at 12:24:52PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 26, 2026 at 11:33 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > On 2026/07/25 23:00, Marc-André Lureau wrote:
> > > rutabaga_cmd_get_capset_info() only fills in capset_id,
> > > capset_max_version and capset_max_size before sending the response to
> > > the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
> > > including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
> > > stack garbage and leaked to the guest, including host pointers useful
> > > for an ASLR bypass.
> > >
> > > Zero the response first, matching virgl_cmd_get_capset_info().
> > >
> > > Not a real risk thanks to -ftrivial-auto-var-init=zero.
> >
> > GCC only added -ftrivial-auto-var-init=zero in GCC 12, while QEMU still
> > supports GCC 10.4/11.

Opps, I thought we had new enough versions already.

> 
> Good point, may be we should update:
> https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/

I'm inclined to bump our min GCC/Clang versions so we can assume
zero-init.

We picked 10.5 due to NetBSD, and CentOS 9 still has 11.x

In both those cases, however, Clang is available in new enough
version to support -ftrivial-auto-var-init=zero. In NetBSD
there are also many new versions of GCC  available, only the
base system GCC is 10.5.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


