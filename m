Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202EEC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEn23-0000r4-WF; Tue, 13 May 2025 06:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEn21-0000qU-Hg
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEn1z-0002OV-Oa
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747132718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdqjJ1WMZZmASOXQhAC8ov8n/jKSMQjpjd+GXsxgHVA=;
 b=SR46fxEfPCtZj84EiP0mkQAhTjFO6Q51rjEYq2EcZ/PjKEDWq1WUTehMHehaxZnoz9NOBW
 SmFTs4aw3xNvZtaEgXWdLIAoG87boLTFK8rEOz+y0npfB4Cy1osmY5fjmqQEvq5/ACp84c
 adpESqsD0olqkKesqymAuoT80ob1I7A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-pKFhuo8_Oi2CWrN3WAhFNA-1; Tue,
 13 May 2025 06:38:35 -0400
X-MC-Unique: pKFhuo8_Oi2CWrN3WAhFNA-1
X-Mimecast-MFC-AGG-ID: pKFhuo8_Oi2CWrN3WAhFNA_1747132712
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DD6E1801A0F; Tue, 13 May 2025 10:38:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A871953B82; Tue, 13 May 2025 10:38:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA1D421E66C2; Tue, 13 May 2025 12:38:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Xiaoyao
 Li <xiaoyao.li@intel.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  kvm@vger.kernel.org,  Gerd
 Hoffmann <kraxel@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-riscv@nongnu.org,  Weiwei Li <liwei1518@gmail.com>,  Amit Shah
 <amit@kernel.org>,  Yanan Wang <wangyanan55@huawei.com>,  Helge Deller
 <deller@gmx.de>,  Palmer Dabbelt <palmer@dabbelt.com>,  Ani Sinha
 <anisinha@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,  Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties
In-Reply-To: <aCMRvH0rWpWlgSNs@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 13 May 2025 10:32:44 +0100")
References: <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
 <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
 <eedd1fa2-5856-41b8-8e6b-38bd5c98ce8f@nutanix.com>
 <87ecwshqj4.fsf@pond.sub.org>
 <60cd3ba8-2ab1-74ac-54ea-5e3b309788a1@eik.bme.hu>
 <aCMRvH0rWpWlgSNs@redhat.com>
Date: Tue, 13 May 2025 12:38:25 +0200
Message-ID: <871pssg5i6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, May 13, 2025 at 11:26:31AM +0200, BALATON Zoltan wrote:
>> On Tue, 13 May 2025, Markus Armbruster wrote:
>> > Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>> > > On a related note this also brings us back to the discussion as to
>> > > the relationship between qdev and QOM: at one point I was under the
>> > > impression that qdev properties were simply QOM properties that were
>> > > exposed externally, i.e on the commmand line for use with -device.
>> > >=20
>> > > Can you provide an update on what the current thinking is in this
>> > > area, in particular re: scoping of qdev vs QOM properties?
>> >=20
>> > qdev is a leaky layer above QOM.
>> >=20
>> > qdev properties are also QOM properties.
>> >=20
>> > All device properties are exposed externally.
>>=20
>> That was clear but the question was if QOM properties (that are not qdev
>> properties) exist and if so are they also exposed? If not exposed it may=
 be
>> used for internal properties (where simpler solutions aren't convenient)=
 but
>> maybe qdev also adds easier definition of properties that's why they used
>> instead of QOM properties?
>
> NB, not everything we expose is a QDev. We directly expose QOM
> via "-object" if they implement the 'UserCreatable' interface.
> If we want internal properties, that should likely be wired in
> to the QOM level directly.

Yes.

As is, all properties of QOM types implementing UserCreatable are part
of the -object / object_add stable external interface.  We lack means to
add properties just for internal use.

Properties of all QOM types (UserCreatable or not) are exposed
externally via qom-get & friends.  This isn't a stable interface except
when it is, but that's a separate problem.

> Conceptually you could even say that everything QEMU creates should
> live under -object, and no other args ought to need to exist. We have
> decades of evolved code making that impractical though.

I doubt we would've invented qdev had QOM existed already.


