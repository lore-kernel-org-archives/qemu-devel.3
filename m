Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD7C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjd3S-0008IZ-CF; Tue, 14 Jul 2026 09:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjd3Q-0008DX-MS
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjd3N-00088C-3V
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784035203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smfGzmt++sYe2uiOzsaJI+8DZ/JIEbxu90paBM6VFpo=;
 b=EN5RTRo9FAxco4KOR/+920z44UXkRMVQZ/x9hLqCgH48yDnXngSklJcdUgL3tvp3t72xDG
 kNyErRpCXBPf4sB3RstDQkxoHAVogHT+/nkKClZl4loF9NToGZx5aOYPtVfiutQjNohlfo
 yzbV3B58zzUKzFdI6XfTHQhRLhrfwTk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-H0hvIwZdN_uL_rcN8hR66Q-1; Tue, 14 Jul 2026 09:20:02 -0400
X-MC-Unique: H0hvIwZdN_uL_rcN8hR66Q-1
X-Mimecast-MFC-AGG-ID: H0hvIwZdN_uL_rcN8hR66Q_1784035201
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-492488f8583so62539295e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784035201; x=1784640001; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=smfGzmt++sYe2uiOzsaJI+8DZ/JIEbxu90paBM6VFpo=;
 b=KooB6t7pGrotQ79M5kbNHze1LRGMhNp63dWWjqCRNWqbryC9UANXTGbWEiGl3m+d6W
 XT9ii/ldfOPoTGU4LdbXvtaE74+rGbth53u1tys9+8YDN7hDx5eArW6sAW4s8Fttv7d/
 lJ2zof+2Bxf7IHpPO1plN3KFmYmVzAgGyXVzgDS4acYHwuiKaIAC0EFEa4ewfEkHNvIW
 o9UUfw/4/lWUOwAJ0BMnSyR+SLf10ZzNUCsNEZHIGO0iFY7xBr+lBJsSdA+9HOJ5hKTQ
 sx4m8duRAoP+qMa/o4WO/VH0PIkJtSXbwLOtJExID7hT2QZ9xvP1Tm6lWlsGMB6D+qM6
 LyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035201; x=1784640001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=smfGzmt++sYe2uiOzsaJI+8DZ/JIEbxu90paBM6VFpo=;
 b=kUIDXPLgkDVZCyFsRwCTXlrNY4tayM8oaF4QDDEbvhfOQVY13INSqUi2tn0IDr884u
 JnVhfymck/O4g9JDzmP9z8LjxjnMEDTSyKUQ/kqU7NP7nhEP+wS04haUvM0V2YtjcsP8
 yb5AqxeWKoIW+Rcp7nHcsFrh0RIEza4QQjWTrXUxOw6JyvJALSOVUwNd2LmWBM+2NHBT
 4y5bjdgp5kHFemPEKw18bn75QLgxebcMdgwP97wFTvZw+AF/0CxqmsPzBROGlTE/koz1
 GchUc7ByLZDy088j6qRq7VWXIpGyu4zdaNJHMA2sRPeMocCIv1FIzxdA4Fbha3zt0RhJ
 npTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI/5+DyENpLfPCzfMVkRkPj6ZCD+Q8+4dlB2ZJboN7EBM4yqxx6mH+1nVzCC+QWg8p7NEhdN+U13v1@nongnu.org
X-Gm-Message-State: AOJu0Yz2L5obo+QcuIR9udZCyck/S6ErFgaYj4E6jIG8yxERma8CB/PO
 edFzR425TFBie9n+aerVzzRzM5ja7JYIqaPaO8h/PrSS60bM+DZCJ0N/g6bCfmdqR341sU4PANF
 cISglkd7QektMiJEt+zan0ynH3JQ9WhSeIWJknPJ0vpoXu8MozOEwCFN+
X-Gm-Gg: AfdE7ckR5mvptLFD9bY10bF5L6JQFCsG14rIzKHu9JNTXQlGBReBPniJgwmAxB+S2cu
 vigmafrzHqubpJiURDJcewBuUrMfY9/2bAoNTIq66AmWSaEuHoSroCZlcJIyY7hgfKm1l/cdedP
 dAIDyOzBl89GAgJsZretF64HZ/jxmGn9JZo5979vzO6dN/PoAZJ8vXWunF/TNc80A1YlC8qUV5F
 kf4ComyvucDytiAF1H90zmK1/xGeFhvILbjReSeVPxqtecSdSW46G7b5x8LTXo6PnaKZdztQeVs
 Ocr6CeeuLt/+tISMd1zvXkOVVeMf4W8kbhwycQ1Rv6pX8AR74WYQnNrzZIHNaePSqYUr/xHEgel
 6NtRXTsuOsEOpNYsFWXe1OEaKtOWST0DhuAc=
X-Received: by 2002:a05:600c:c16a:b0:493:b89b:9a27 with SMTP id
 5b1f17b1804b1-495389d2a9cmr25759775e9.9.1784035200430; 
 Tue, 14 Jul 2026 06:20:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c16a:b0:493:b89b:9a27 with SMTP id
 5b1f17b1804b1-495389d2a9cmr25759095e9.9.1784035199789; 
 Tue, 14 Jul 2026 06:19:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495086ca93esm72997645e9.0.2026.07.14.06.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:19:59 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:19:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>, jasowang@redhat.com,
 peterx@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
Message-ID: <20260714091858-mutt-send-email-mst@kernel.org>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
 <875x2juxru.fsf@pond.sub.org>
 <0fd09b96-068f-415d-9bd8-0506958710f1@yandex-team.ru>
 <87y0fff25t.fsf@pond.sub.org>
 <5af44296-ea89-402c-b4fb-b9b0acee3b54@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af44296-ea89-402c-b4fb-b9b0acee3b54@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13, 2026 at 06:08:26PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 13.07.26 16:29, Markus Armbruster wrote:
> > Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> > 
> > > On 13.07.26 10:57, Markus Armbruster wrote:
> > > > Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> > > > 
> > > > > Support transferring of TAP state (including open fd).
> > > > > 
> > > > > Add new property "local-migration-supported", which defines
> > > > > whether local-migration is actually supported for this TAP device.
> > > > > Starting from 11.2 QEMU Machine Types it's enabled by default.
> > > > > 
> > > > > Note, that local-migration (including migrating opened FDs
> > > > 
> > > > Scratch the comma after "Note", ...
> > > > 
> > > > > through migration channel, which must be UNIX socket), is
> > > > 
> > > > ... and the one before "is".
> > > > 
> > > > > enabled by global "local" migration parameters. But individual
> > > > > devices may have additional options to enable/disable it
> > > > > per device.
> > > > > 
> > > > > The tricky thing, is that we need to know, should we do
> > > > 
> > > > Do you mean "The tricky thing is that we ween to know whether to call"?
> > > 
> > > yes
> > > 
> > > > 
> > > > > call open/connect in TAP initialization code. That means,
> > > > > that on incoming migration we want to know status of
> > > > > "local" migration parameter at time of creating TAP device.
> > > > > So, currently, for incoming local migration only TAP device
> > > > > created through QMP is supported, as you need to set migration
> > > > > parameter first (through QMP as well).
> > 
> > Possibly clearer:
> > 
> >      The tricky thing is that we need to know whether to call open/connect
> >      in TAP initialization code, i.e. we need to know the value of
> >      migration parameter "local" when creating the TAP device.  For
> >      incoming migration, we can know only for TAP devices created with QMP
> >      after setting the migration parameter with QMP.
> > 
> > > > > 
> > > > > So the full picture is:
> > > > > 
> > > > > On source, to start outgoing "local" migration you need:
> > > > > 
> > > > >    - migration parameter "local" set to true
> > > > >    - "local-migration-supported" TAP option set to true (the
> > > > >      default, starting from 11.2 QEMU Machine Types)
> > > > > 
> > > > > If at least one of these options is not set, TAP backend
> > > > > doesn't participate in migration.
> > > > > 
> > > > > On target, things are more difficult:
> > > > > 
> > > > > Same, you need both "local" and "local-migration-supported"
> > > > > be set. And same, if one of them is not set, TAP backend
> > > > > is initialized as usual, and doesn't accept any incoming
> > > > > state.
> > > > > 
> > > > > Additionally, if you are going to set "local", it must be
> > > > > set before creating the TAP device. If TAP device created
> > > > > with "local" unset, it initializes as usual. If you enable
> > > > > "local" after it and start incoming migration, it will fail
> > > > > in .pre_load handler of TAP backend.
> > > > 
> > > > Out of curiosity, how would such a failure look like?
> > > 
> > > TAP is initialized as usual, so the answer depends on the options.
> > > 
> > > For incoming migration we should open TAP without "ifname" argument.
> > > If so (and "local" is not set), new TAP device will be created. It
> > > shouldn't trigger any additional problems I think.
> > > 
> > > 
> > > Checking with test:
> > > 
> > >     diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
> > >     index bcc0a60dfe9..94982bc7b55 100755
> > >     --- a/tests/functional/x86_64/test_tap_migration.py
> > >     +++ b/tests/functional/x86_64/test_tap_migration.py
> > >     @@ -316,8 +316,8 @@ def prepare_and_launch_vm(
> > >              else:
> > >                  tap_name = TAP_ID
> > > 
> > >     -        self.set_migration_capabilities(vm, local)
> > >              self.add_virtio_net(vm, vhost, tap_name, local, incoming)
> > >     +        self.set_migration_capabilities(vm, local)
> > > 
> > >          def add_virtio_net(
> > >              self, vm, vhost: bool, tap_name: str, local: bool, incoming: bool
> > > 
> > > 
> > > Leads to
> > > 
> > > qemu-system-x86_64: TAP is already initialized and cannot receive incoming fd
> > > qemu-system-x86_64: warning: qemu_fclose: received fd 27 was never claimed
> > > qemu-system-x86_64: load of migration failed: Invalid argument: error while loading state for instance 0x0 of device 'netdev.1/0/net-tap': pre load hook failed for: 'net-tap', version_id: 0, minimum version_id: 0, ret: -22
> > > 
> > > on target, and failed migration, as expected.
> > 
> > How is the user supposed to reason their way from here to "oh, I need to
> > create my TAP device with QMP and after setting @local"?
> 
> Not trivial, yes.
> 
> I can update error message to
> 
>    TAP is already initialized and cannot receive incoming fd. For local migration, "local" migration parameter must be set _before_ creating TAP device.


Another reason to just make it a machine property globally
and be done with it, maybe?

> > 
> > > 
> > > > 
> > > > > Moreover, there are interface restrictions: if you create TAP
> > > > > device when QEMU is in INCOMING state, and both "local"
> > > > > and "local-migration-supported" set, most of TAP options are
> > > > > not allowed, and script/downscript are required to be explicitly
> > > > > unset (set to "" or "no").
> > > > > 
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> > [...]
> > 
> 
> 
> -- 
> Best regards,
> Vladimir


