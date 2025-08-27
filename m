Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4B8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBHj-0008Qk-Aq; Wed, 27 Aug 2025 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1urBHe-0008Kh-3c
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1urBHZ-00051v-MW
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756282404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0sJo/EOc+Q0sH52yHHjDp1WFnjCFWmnxBjE7uvB35g=;
 b=eYYluCneAZKhyfWc6AO3w5A2EQMHqR6DiEMPve5+ChPpDx7UQa09UYKQRljcVK5RhXEd/j
 MEFNkZaDEILJfC0uPbicmvg7GCSttfHyahVUV45Rz4LeKGHSv3Zde/AYkpj5DqIxhTi7Yt
 FXCOEWvR3gxupY7sAoy4W2pdbQ0xGO0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-aZ4hcrHIMVWF6WPf7nQQXQ-1; Wed,
 27 Aug 2025 04:13:20 -0400
X-MC-Unique: aZ4hcrHIMVWF6WPf7nQQXQ-1
X-Mimecast-MFC-AGG-ID: aZ4hcrHIMVWF6WPf7nQQXQ_1756282399
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1F3619541A0; Wed, 27 Aug 2025 08:13:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 540ED30001A8; Wed, 27 Aug 2025 08:13:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A929221E6A27; Wed, 27 Aug 2025 10:13:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Jason
 Wang <jasowang@redhat.com>,  Andrew Melnychenko <andrew@daynix.com>,  Yuri
 Benditovich <yuri.benditovich@daynix.com>
Subject: Re: ebpf functions can fail without setting an error
In-Reply-To: <2de22a4d-3e09-466a-ae66-e07c77c9532e@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 25 Aug 2025 15:27:14
 +0200")
References: <87ectns27j.fsf@pond.sub.org> <aKRWZwvbWzA0QbA_@redhat.com>
 <87sehfsife.fsf@pond.sub.org>
 <2de22a4d-3e09-466a-ae66-e07c77c9532e@linaro.org>
Date: Wed, 27 Aug 2025 10:13:15 +0200
Message-ID: <87bjo1kwro.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 25/8/25 14:19, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Thu, Aug 07, 2025 at 03:14:56PM +0200, Markus Armbruster wrote:
>>>> Three functions in ebpf_rss.h take an Error ** argument and return boo=
l.
>>>> Good.
>>>>
>>>> They can all fail without setting an error.  Not good.
>>>>
>>>> The failures without error are:
>>>>
>>>> * All three stubs in ebpf_rss-stub.c always.  Oversight?
>>>
>>> Opps, yes, we really should have added error_setg() calls for diagnosis
>>> if someone tries to use eBPF when QEMU build has it disabled.
>>=20
>> Some stubs exist only to mollify the linker.  They are not meant to be
>> called.  They should abort(), optionally with lipstick.
>
> When a host feature availability is known a compile time.
>
> These should be guarded with a if (feature_enabled()) to allow the
> compiler to elide the call, thus removing the need for stubs.

With if (...) guards, compilers need not elide the call (although a
sufficiently smart optimizing compiler will).  Only #if guards remove
the need for stubs with certainty.

Guards can also be implicit.  For instance, when creation of some
(sub-)object always fails, then all its methods are unreachable.  This
can serve as guard for calls of stubs in the methods.

Of course, not compiling and linking unreachable code in the first place
is desirable, but sometimes the #if are just too bothersome.

>> Other stubs are called and should fail nicely.
>>=20
>> Can you tell me offhand which kind these are?
>
> When a host feature availability is known a runtime.
>
>>=20
>>>> * Non-stub ebpf_rss_load() when ebpf_rss_is_loaded().  Are these
>>>>   reachable?

Scratch ebpf_rss_is_loaded(), it doesn't take @errp.

> meson calls:
>
>    config_host_data.set('CONFIG_EBPF', libbpf.found())
>
> (even QAPI uses CONFIG_EBPF, see qapi/ebpf.json).

Yes.

C code doesn't use CONFIG_EBPF.  Instead, compilation of certain C files
is conditional on the libbpf Meson dependency.

> The user API is via the 'ebpf-rss-fds' property,
> evaluated in virtio_net_load_ebpf_fds() without returning
> any error when 1/ ebpf_rss_load_fds() fails (due to real
> error or no CONFIG_EBPF -- the stub).

If the user requested EBPF by setting the property, we call
ebpf_rss_load_fds() via virtio_net_load_ebpf_fds().

If CONFIG_EBPF, this can fail.  It sets an error then.

Else, it will fail, and it won't set an error then.  Feels wrong.
Impact unclear.  To find out I'd have to figure out how to configure
virtio-net to make it attempt to use EBPF.

> IMO if the normal implementation function sets some errp,
> then the stub must also set it ("feature not available").
> Otherwise such function shouldn't take an errp at all.

Convention: a function taking an @errp must set its @errp exactly when
it fails.

Does not apply when it abort()s.

I like unreachable stubs to abort().

ebpf_rss_load() and ebpf_rss_load_fds() are only called from
.get_features method virtio_net_get_features().  Reachability is not
obvious.  If we assume they are reachable, we need to make the two stubs
set an error.

ebpf_rss_set_all() is only called from virtio_net_commit_rss_config()
via virtio_net_attach_ebpf_rss().  virtio_net_attach_ebpf_rss() passes
null @errp, i.e. the errors set by ebpf_rss_set_all() are all lost.
virtio_net_attach_ebpf_rss() emits a generic warning on failure.  This
is crap.  Better: virtio_net_attach_ebpf_rss() passes on the error, so
that virtio_net_commit_rss_config() can include cause in the warning.

If we do that, we also need to fix the stub to set an error.

If we don't do it, we can just as well drop ebpf_rss_set_all()'s @errp
parameter.

> Reasoning valid for:
> - ebpf_rss_load
> - ebpf_rss_load_fds
> - ebpf_rss_set_all
>
> As the name suggest, ebpf_rss_is_loaded() shouldn't be called
> when eBPF not available, because ebpf_rss_load() would return
> an error. Not reachable.
>
> Unfortunately ebpf_rss_init() doesn't return anything. "Feature
> available" and "Initialization successful" are different cases,
> so having it return a boolean isn't really helpful. I'd have the
> stub assert if reached, and check the feature availability upfront.

I'm not sure I follow.

> Declaring ebpf_available() in "ebpf/ebpf_rss.h" as:
>
>    static inline bool ebpf_available(void)
>    {
>    #ifdef CONFIG_EBPF
>        return true;
>    #else
>        return false;
>    #endif
>    }
>
> along with the prototypes, would allow the compiler to elide the callees
> when not available, removing the need for various stubs.

Only if we're willing to assume all compilers elide the calls even when
optimization is off.

>>> This scenario should never happen, and we should add a call like
>>>
>>>    error_setg(errp, "eBPF program is already loaded");
>>>
>>> to report it correctly.
>>=20
>> Is it a programming error when it happens?


