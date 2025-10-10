Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B045ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75EB-0002Vg-SQ; Fri, 10 Oct 2025 00:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v75EA-0002V3-6k
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v75E1-0001ZU-Qt
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760072362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2z1w9Lnhze5+3c99FIjGbAIMKd++Ed0320hJGHvmgyY=;
 b=DcFhQ0JqmuG6V2jv4RmPrq8fYwVLr28WfyTyyQXFvkfPWjrs3Ji6cm4sULj+A8VNFwoeD5
 TWLv0uTXuAt/KJ2f95DHSVp6iN0FhtpC9VLyFc6qmVUudnC6ute2jLU3lDbZsuDJQHFsYf
 iQLMQdXbhKvXMCc+shMxTsTYRdPWXqI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-QF6lu1PHMfyCrXBf53jfJg-1; Fri,
 10 Oct 2025 00:59:18 -0400
X-MC-Unique: QF6lu1PHMfyCrXBf53jfJg-1
X-Mimecast-MFC-AGG-ID: QF6lu1PHMfyCrXBf53jfJg_1760072354
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DFC7180034F; Fri, 10 Oct 2025 04:59:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756703000381; Fri, 10 Oct 2025 04:59:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B199521E6A27; Fri, 10 Oct 2025 06:59:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,  salil.mehta@opnsrc.net,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  mst@redhat.com,
 salil.mehta@huawei.com,  maz@kernel.org,  jean-philippe@linaro.org,
 jonathan.cameron@huawei.com,  lpieralisi@kernel.org,
 richard.henderson@linaro.org,  andrew.jones@linux.dev,  david@redhat.com,
 philmd@linaro.org,  eric.auger@redhat.com,  will@kernel.org,
 ardb@kernel.org,  oliver.upton@linux.dev,  pbonzini@redhat.com,
 gshan@redhat.com,  rafael@kernel.org,  borntraeger@linux.ibm.com,
 alex.bennee@linaro.org,  gustavo.romero@linaro.org,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  linux@armlinux.org.uk,
 darren@os.amperecomputing.com,  ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com,  gankulkarni@os.amperecomputing.com,
 karl.heubaum@oracle.com,  miguel.luis@oracle.com,  zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com,  wangyanan55@huawei.com,
 wangzhou1@hisilicon.com,  linuxarm@huawei.com,  jiakernel2@gmail.com,
 maobibo@loongson.cn,  lixianglai@loongson.cn,  shahuang@redhat.com,
 zhao1.liu@intel.com,  devel@lists.libvirt.org
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
In-Reply-To: <CAFEAcA9wa2_c5YYwYJRL-aZThujxYPt1mg3zy_YEBaQ_8cX3Xw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 9 Oct 2025 16:19:21 +0100")
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org> <20251009145125.6583a24a@fedora>
 <87wm54nmyt.fsf@pond.sub.org>
 <CAFEAcA9wa2_c5YYwYJRL-aZThujxYPt1mg3zy_YEBaQ_8cX3Xw@mail.gmail.com>
Date: Fri, 10 Oct 2025 06:59:05 +0200
Message-ID: <87ecrbmjxi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 9 Oct 2025 at 15:56, Markus Armbruster <armbru@redhat.com> wrote:
>> qdev introspection (device-list-properties) is like QOM type
>> introspection.  I'm not sure why it exists.
>
> It exists because it is the older of the two interfaces:
> device-list-properties was added in 2012, whereas
> qom-list-properties was only added in 2018.

I suspected it was, but didn't want to make unchecked claims.  Thanks
for checking!

> device-list-properties also does some device-specific
> sanitization that may or may not be helpful: it won't
> let you try it on an abstract base class, for instance,

Introspecting abstract bases is probably not useful.  But what harm
could it do?  Can't see why preventing it is worth the bother.  Of
course, changing it now is not worth the bother, either :)

> and it won't list "legacy-" properties.

I remember these exist, but not what they're good for :)

Should we deprecate device-list-properties in favour of
qom-list-properties?

> One problem you don't mention with QOM introspection is
> that we have no marking for whether properties are intended
> to be user-facing knobs, configurable things to be set
> by other parts of QEMU, or purely details of the implementation.

Yes.  This is what I had in mind when I pointed out "accidental external
interfaces".


