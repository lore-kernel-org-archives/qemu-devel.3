Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB94D41D57
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiIO-0006GZ-Gj; Thu, 11 Dec 2025 10:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTiII-0006EJ-Hw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTiIF-00007Y-VV
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765465761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YD+hHI75a5sWoxcgZmLdqoIe618gzZ/AY5soiKL5KbM=;
 b=URoCM5+F8Llr1/MVVb3qQxxlIUQGoRoG08THt/1FDM8NejP5Jso6fRmuxEVgeUCwCQIRTU
 HsD98R7e4QxyZu/cbUSgCLwTQJOfCnBJxmuTWoJhZmpslWlVshgcreV086KT4pdQmt3SJI
 PP2Hhp3lwFGKUCOITiqotW8pcauuU2k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-e82WcWQdOiOgF9_zghIHMg-1; Thu, 11 Dec 2025 10:09:20 -0500
X-MC-Unique: e82WcWQdOiOgF9_zghIHMg-1
X-Mimecast-MFC-AGG-ID: e82WcWQdOiOgF9_zghIHMg_1765465759
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2e41884a0so40641585a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765465759; x=1766070559; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YD+hHI75a5sWoxcgZmLdqoIe618gzZ/AY5soiKL5KbM=;
 b=peKnm8Ip99ot5d01oqV00gpOMdyRupUusUYoZsaOHX1C2KmySaCCmNK7rONl/VWZCi
 2wlhhQugWPWn4l5yy4MTph/fpTAHHeZBu7pZeSz2/5AJwJ1kqWQZGVXZ/XSN9sWHaAVv
 gPGHfZ0pwVV0mT8fiet17uuijpSSK2lLSlH4ZT3PkHSGTi5ojM8kCQhIbhK4hw05XInT
 maAgWtfN2EjwxsGp8SHMjqSgCaT6w2Dl1SmCye38XkIL70MerdDwrMfXVt//Gc6pLly0
 yXd/g8N0E35hzkoNmgEX6WNfIe3kwHyTKoY1JANB36L3FxeSACb+MsZiZvEUui/x0w32
 8PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765465759; x=1766070559;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YD+hHI75a5sWoxcgZmLdqoIe618gzZ/AY5soiKL5KbM=;
 b=KH0IYhyzfxm2iuBzc7RWWm3i2/2MaAbTIjP7Lv6O8/+vfAu1S7qc8r82hkqNtltwXm
 Phm57uc/KIzcbg3WmhSDqDdyd7tNDL2lqCl8Vqdk0VEL1mb1SUg/JomJKzOiVjd+6JPj
 XqtHiZxnpfU4AV00/r1qJDMZGblcFOxU/qa1r3EBBOM1unvzuNOPw6BMdqxe5Hjf8rEA
 ScmozfmauBO5XW1SSTsLFaorGhrx/7PK8nImxEsQlLE6cnYHiVBEj/gxGLF3NNTZL1Qs
 m1w3FIobU5Qn6iarvXwy6CPvfDGBZAV1EhPGvStgXw0VeT5t1qgsPXFQkvLj2kRxo4Lx
 N2ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl+cT52nWBFR8lyHCKW2bGAlOYfYZ7Mbdm+zckS1co3Yrq37AwzPbxGZ/H4ifTFBBN/tkVgYndNW0w@nongnu.org
X-Gm-Message-State: AOJu0YyJXQ18gEal8DQqHnsJj1QU6GMB+cBEgRC5/TW32gn8NoBV64nA
 0bGWRN9zvoXp4BID684asySSq7ms3Nol/gxBF3cmHtIBFVnLDBLoMawcs6HPHE956b1kJ2SzjLd
 55j95iTWD22LGy8fIfUeaLKdJ7gN5nMPeEqtCUfGGoCdbZ3RQk8Qs4XIy
X-Gm-Gg: AY/fxX6Ga9wmByGvEP2hfrlgzGs3gM8VuvY0OY5+E9miWdH0Lx7IvrK19Gq3yFHTSXm
 IHBwQQmUvQu0oFH8PoiwG5ygUGgMKYIDgWEkyMWq/3ltumn8rThbFU3PoLkEojj3amRBtOrgJVz
 383xi1wfvJHBrYixKf7IdJo/9RLQhxra2j0WXABTcSnG08LpVBXHdNjfS1JVco8tlxVQrVd2DmI
 tbCVMNhs7l1SuxFff4Se5BqRzfISGejAVZt+OwQKcFs9wONarlqSYnupnZmeRu6TPm0s6buTqfq
 kdEdfJJ6l4A/E4CoU3uYo/Kbg4geUAhBM/Z7qHZxsYxfMCQQuFcj/vnVs3PnBtuS7tazME/mbej
 /O/c=
X-Received: by 2002:a05:620a:2a09:b0:8b2:edc8:13d0 with SMTP id
 af79cd13be357-8ba39a32647mr977245285a.17.1765465759329; 
 Thu, 11 Dec 2025 07:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnV0J8WJ7gT2lCrrNtC8ETortmK4FUZ1kHDNkflLex47mcQW56sEU5IlbrCbA4jkMmRmzQ9w==
X-Received: by 2002:a05:620a:2a09:b0:8b2:edc8:13d0 with SMTP id
 af79cd13be357-8ba39a32647mr977235785a.17.1765465758703; 
 Thu, 11 Dec 2025 07:09:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab566608asm235861085a.21.2025.12.11.07.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 07:09:18 -0800 (PST)
Date: Thu, 11 Dec 2025 10:09:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTrenNP7Vq4XO2DP@x1.local>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com> <aTle5C2pN8ZslZX7@redhat.com>
 <aTmdJ5H67mk8qmSC@x1.local> <aTqTcM9zsGpW-F45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTqTcM9zsGpW-F45@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 11, 2025 at 09:48:32AM +0000, Daniel P. Berrangé wrote:
> The appealing thing about machine types is that it is an opaque
> collection of properties. The mgmt app does not need to know about
> any of the properties being set, it can just let the machine type
> do its magic.
> 
> Probing values for individual features which are supported on a host
> means mgmt apps need to be made aware of all the properties that are
> affected, and keep track of them for the life of the VM. This is a
> significantly higher burden for the mgmt app to deal with that the
> opaque collection machine types define, especially because apps won't
> know ahead of time which objects/properties might need this facility
> in future.

Yes, exactly.

IMHO we may still need "probing" of host features at some point, but we do
have two completely different way to stable the guest ABI:

  (a) Machine types (like now)
  (b) "probing" + "QMP set()s"

Here "QMP set()s" can be QMP updating a property of an object, or something
like what Vladimir proposed in the other virtio-net/tap series, via a
separate new QMP command.

Solution (b) has a major benefit of high flexibility - we do not need
machine type versioning anymore (hence, we still need "q35", but not
"q35-X.Y" etc.), because any QEMU can likely migrate to almost any QEMU:
mgmt will probe both sides and apply mini subset for both sides, no matter
how old it was.

To pay that off, mgmt needs to know every single trivial detail of QEMU
change on every single device to make migration work.  When new things
introduced to QEMU, it must be OFF, then mgmt turns it on until probing
both sides have it.

That makes solution (b) less appealing.

The other thing is, since we stick with solution (a) for all these years,
IMHO we should either stick with it, or if we really think (b) is better we
should gradually obsolete (a) and use (b) all over.  I just don't see it
coming, though.. as (a) is still working almost perfect - it enables
feature slower only until a new machine type used (normally means a VM cold
reboot), but it hides too many trivial details mgmt doesn't need to care,
hence much less work needed.

IMHO we should be careful on making both (a)+(b) available (again, for (b)
the probing is still fine, it's about offloading things to mgmt to set()
via QMPs).  If so, it likely implies we didn't think all things through.

Thanks,

-- 
Peter Xu


