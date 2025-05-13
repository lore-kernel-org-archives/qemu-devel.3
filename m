Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44700C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 08:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEkgk-0005CS-6P; Tue, 13 May 2025 04:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEkgi-0005BZ-Nj
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEkgg-0003Za-Mp
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747123708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+Gv9eTQq4KU9E7dEF3HAfmHKcWMwL8LbrI4vrBOurs=;
 b=Joo+orzOBbh5yeo00KQNwo2qCAzrij3pJalr/cSTqLtzPD0YMtCDKjCARQ468TAko2yK1/
 opuOH9cpy43m/jlHt6603O8EI/cXP+VdgbtgwBEqXhWGQ8NOKz5VQ+g+bf7YU9CJ1LMCSy
 cwGpnfgpaezXzVACKr50QSpNUvl4T7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-Tdm_Y8VHNDu_jRyW3wVE9A-1; Tue,
 13 May 2025 04:08:24 -0400
X-MC-Unique: Tdm_Y8VHNDu_jRyW3wVE9A-1
X-Mimecast-MFC-AGG-ID: Tdm_Y8VHNDu_jRyW3wVE9A_1747123701
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E6531955D8F; Tue, 13 May 2025 08:08:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AFA818003FC; Tue, 13 May 2025 08:08:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C227321E66C3; Tue, 13 May 2025 10:08:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Xiaoyao Li <xiaoyao.li@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org,  Gerd Hoffmann <kraxel@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Yi Liu
 <yi.l.liu@intel.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-riscv@nongnu.org,  Weiwei Li <liwei1518@gmail.com>,  Amit Shah
 <amit@kernel.org>,  Yanan Wang <wangyanan55@huawei.com>,  Helge Deller
 <deller@gmx.de>,  Palmer Dabbelt <palmer@dabbelt.com>,  Ani Sinha
 <anisinha@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>,  qemu-arm@nongnu.org,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Huacai Chen
 <chenhuacai@kernel.org>,  Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties
In-Reply-To: <20250512172226.433900f8@imammedo.users.ipa.redhat.com> (Igor
 Mammedov's message of "Mon, 12 May 2025 17:22:26 +0200")
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
 <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
 <20250512172226.433900f8@imammedo.users.ipa.redhat.com>
Date: Tue, 13 May 2025 10:08:15 +0200
Message-ID: <87msbhgcgg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon, 12 May 2025 12:54:26 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, May 12, 2025 at 09:46:30AM +0100, Peter Maydell wrote:=20=20
>> >> On Fri, 9 May 2025 at 11:04, Thomas Huth <thuth@redhat.com> wrote:=20=
=20
>> >> > Thanks for your clarifications, Zhao! But I think this shows again =
the
>> >> > problem that we have hit a couple of times in the past already: Pro=
perties
>> >> > are currently used for both, config knobs for the users and internal
>> >> > switches for configuration of the machine. We lack a proper way to =
say "this
>> >> > property is usable for the user" and "this property is meant for in=
ternal
>> >> > configuration only".
>> >> >
>> >> > I wonder whether we could maybe come up with a naming scheme to bet=
ter
>> >> > distinguish the two sets, e.g. by using a prefix similar to the "x-=
" prefix
>> >> > for experimental properties? We could e.g. say that all properties =
starting
>> >> > with a "q-" are meant for QEMU-internal configuration only or somet=
hing
>> >> > similar (and maybe even hide those from the default help output whe=
n running
>> >> > "-device xyz,help" ?)? Anybody any opinions or better ideas on this=
?=20=20
>> >>=20
>> >> I think a q-prefix is potentially a bit clunky unless we also have
>> >> infrastructure to say eg DEFINE_INTERNAL_PROP_BOOL("foo", ...)
>> >> and have it auto-add the prefix, and to have the C APIs for
>> >> setting properties search for both "foo" and "q-foo" so you
>> >> don't have to write qdev_prop_set_bit(dev, "q-foo", ...).=20=20
>>=20
>> If we make intent explicit with DEFINE_INTERNAL_PROP_FOO(), is repeating
>> intent in the name useful?
>
> While we are inventing a new API, I'd say that _INTERNAL_ is not the only=
 thing
> on my wish-list wrt properties.
> It would be also nice to know when a property is set by internal or exter=
nal user
> or if it still has default value.

We commonly assume "value is default implies user didn't touch it",
which is of course wrong unless it's a value the user cannot set.

> Basically we are looking at different flags for properties and INERNAL be=
ing
> one of them.
>
> Maybe instead of specialized macro, we should have a more generic
>    DEFINE_PROP_WITH_FLAGS_FOO(...,flags)
> So we won't have to rewrite it again when we think of another flag to tur=
n on/off.
>
>
> From previous uses of x- flag, some of such properties are created as
> temporary | developer-only and occasionally as a crutch (still no intende=
d for end user).
> But then sometimes such properties get promoted to ABI with fat warnings
> not to touch them. Having stable|unstable flag could help here without
> need to rename property (and prevent breaking users who (ab)used it if we=
 care).

I think QAPI's explicit 'unstable' and 'deprecated' flags have been a
success.  Their meaning is clear, and they come with documentation
(because adding them without won't compile).

Pushing QOM closer to QAPI when we can makes sense to me.


