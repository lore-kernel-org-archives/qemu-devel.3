Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960E2D41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjAT-0001Ln-5V; Thu, 11 Dec 2025 11:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTjAR-0001Gs-0M
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTjAO-0005f4-Dq
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765469119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xZHP6jvOA6pHJbmgu03YLTceq1gh2DaRrR/YyCbfKU=;
 b=C1YjfhW7YL84ipuYgCo3Y2PbcOxl2Ds7S2UlxqaGjuNaNVq1wa49ABvAYrur0gRmskDCAw
 y8NQRHt1PFtNw+7RbkzNvlDPiSfLPQQ+FiKKMiYxoafpV4+k5YkmVBQvdb/zP7twUmk7yZ
 dAoK8wKzZUE+k/TiYJH/21A2o67pyW8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-svj59us0Mku0K0aQZDX32w-1; Thu, 11 Dec 2025 11:05:15 -0500
X-MC-Unique: svj59us0Mku0K0aQZDX32w-1
X-Mimecast-MFC-AGG-ID: svj59us0Mku0K0aQZDX32w_1765469115
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ee21a0d326so3535201cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765469115; x=1766073915; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/xZHP6jvOA6pHJbmgu03YLTceq1gh2DaRrR/YyCbfKU=;
 b=m6Lm9z5IxwS3e8CnwyPbnP2qdVUTVcf4jlYr5KyJi7s1FphQ4+7H394oFxc1b1W/Ok
 pazTVD5/bwkPsrEiu/sAobTnnrXhdD5MNpeP6B0mkj/2Aall2vU/XjCt1PkaoAMKwnrB
 XEo2aUe/zSMPoSNcIuFerGTQrGZ9rtlTPT8kOSFaeYdbXjXqKzQ8GaOJLtn8w4lv3Lej
 nvmNLBWtt0QL9mk/X9394MI+vqHvnLVoP9e5dAnvOfHFr2tz1ilML9hJDwgujrSg2yYY
 MH1R0KkpyQe5sGEQdUXEoqrv1f4rOJfhNYbGueV+suTqCuSHglPos24i3jtiIiDSSFrq
 TRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765469115; x=1766073915;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/xZHP6jvOA6pHJbmgu03YLTceq1gh2DaRrR/YyCbfKU=;
 b=XAsZJP6Zpfw5k9k9T5z3KWNbz3nxMt8Zg/euiSD+CTAehyO7a7WA6F5EwHk/2cFJeb
 P1z1lh1/VvTAbiRjuT/uHhNSCEzxqFCM5qHHKziQvQec5WLD1TdgN8cvndcwV8mzOieq
 QNqQWwOdhG7zjBjRphqD63AzqKsM++5kSaeBNVRnPDw0aWkmDKwM/+BmXl0aRA38CHHZ
 l3DCsAVHLSe9oquyh5mmAuFuS8ao4H6MaoRIpdSmLYpsYa3KYJFFUT/eFPa8WOE+eY+j
 YhGaRRdyI9x3SRzP4+iXp5LOjrFgr3alRhBeOSEC3AObFdFDEKS8+zbj+P4aUU5LII9C
 R5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU796KE8iJwTppKf7wVCBoISw2miwUJySnxDg4DU4bCFPoYC6k/1i3XSDDWlcCN6mZmKG+YYoFfrHVt@nongnu.org
X-Gm-Message-State: AOJu0YwdxOROaxy7d//7xiM/om51SWB3M1Zi7chx03EkgC98ACg699t9
 +ab6di6gsWzDW+3RQauhx3m0I0p6NMSqW7Ez/9cBcIByvHmzh5sBecF4JEvfyERV1nyS+X/5whm
 agzcISh9gjSRina6ta0iMA7xoyxO4D4NGh9PybnchHSq5gJGY4q97oXzh
X-Gm-Gg: AY/fxX4rvjlxF4g4UmJHxSz5ntI0Pf4TX/pYo2Fl+w0tTwrHtD8VdeKDLnwogl2HoTT
 y3fDfLPlI4NaXYMqkxypc7QSfoKK/rhKhS9oIrooEdTw3B+LiX9rEXCyFJMePBdlsrECVOqYo9+
 QMMM27mbOxB+pTLcTVMj2DX88P5Fl6Bv5euRmg7iSDCWtOG8TwXXnMH8GlI+ilSAgv+QRGZN+Ab
 sfts0tN9feaIJJYtM/zGIg20mYYUrXzK5IdDcQePbwT/Asn1bgx/k4iJkEq+BqT5mE3pCedIldA
 Ej600Nx48gz7goqHaLF9d5GL0tFKjALlUyiK44ymhKhXSAt66teWgcwsb1kP1qVj6yAKCnHVV67
 r6aY=
X-Received: by 2002:ac8:580a:0:b0:4ee:1676:faa6 with SMTP id
 d75a77b69052e-4f1b1a69b7cmr93635961cf.20.1765469114729; 
 Thu, 11 Dec 2025 08:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEntdBTiaJSMo3Lgp3WVB9FwNe2ASc/72wMM0KtuyQIayQ8O7OzD8p4OamfqgL4J8TECPclnA==
X-Received: by 2002:ac8:580a:0:b0:4ee:1676:faa6 with SMTP id
 d75a77b69052e-4f1b1a69b7cmr93634971cf.20.1765469113889; 
 Thu, 11 Dec 2025 08:05:13 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1bd58d63esm19378831cf.3.2025.12.11.08.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:05:13 -0800 (PST)
Date: Thu, 11 Dec 2025 11:05:11 -0500
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
Message-ID: <aTrrt1OODz2ELU0X@x1.local>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com> <aTle5C2pN8ZslZX7@redhat.com>
 <aTmdJ5H67mk8qmSC@x1.local> <aTqTcM9zsGpW-F45@redhat.com>
 <aTrenNP7Vq4XO2DP@x1.local> <aTricLooEPFJqZhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTricLooEPFJqZhe@redhat.com>
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

On Thu, Dec 11, 2025 at 03:26:13PM +0000, Daniel P. Berrangé wrote:
> On Thu, Dec 11, 2025 at 10:09:16AM -0500, Peter Xu wrote:
> > On Thu, Dec 11, 2025 at 09:48:32AM +0000, Daniel P. Berrangé wrote:
> > > The appealing thing about machine types is that it is an opaque
> > > collection of properties. The mgmt app does not need to know about
> > > any of the properties being set, it can just let the machine type
> > > do its magic.
> > > 
> > > Probing values for individual features which are supported on a host
> > > means mgmt apps need to be made aware of all the properties that are
> > > affected, and keep track of them for the life of the VM. This is a
> > > significantly higher burden for the mgmt app to deal with that the
> > > opaque collection machine types define, especially because apps won't
> > > know ahead of time which objects/properties might need this facility
> > > in future.
> > 
> > Yes, exactly.
> > 
> > IMHO we may still need "probing" of host features at some point, but we do
> > have two completely different way to stable the guest ABI:
> > 
> >   (a) Machine types (like now)
> >   (b) "probing" + "QMP set()s"
> > 
> > Here "QMP set()s" can be QMP updating a property of an object, or something
> > like what Vladimir proposed in the other virtio-net/tap series, via a
> > separate new QMP command.
> > 
> > Solution (b) has a major benefit of high flexibility - we do not need
> > machine type versioning anymore (hence, we still need "q35", but not
> > "q35-X.Y" etc.), because any QEMU can likely migrate to almost any QEMU:
> > mgmt will probe both sides and apply mini subset for both sides, no matter
> > how old it was.
> > 
> > To pay that off, mgmt needs to know every single trivial detail of QEMU
> > change on every single device to make migration work.  When new things
> > introduced to QEMU, it must be OFF, then mgmt turns it on until probing
> > both sides have it.
> > 
> > That makes solution (b) less appealing.
> > 
> > The other thing is, since we stick with solution (a) for all these years,
> > IMHO we should either stick with it, or if we really think (b) is better we
> > should gradually obsolete (a) and use (b) all over.  I just don't see it
> > coming, though.. as (a) is still working almost perfect - it enables
> > feature slower only until a new machine type used (normally means a VM cold
> > reboot), but it hides too many trivial details mgmt doesn't need to care,
> > hence much less work needed.
> > 
> > IMHO we should be careful on making both (a)+(b) available (again, for (b)
> > the probing is still fine, it's about offloading things to mgmt to set()
> > via QMPs).  If so, it likely implies we didn't think all things through.
> 
> I don't believe that probing could ever be a placement for (a). Determining
> what you want to use is not a decision that can be made in isolation of
> the current host. You need to know the capabilities of hosts that you
> intend to be able to migrate to.
> 
> Machine type versions facilitate this as an admin can express the
> compatibility constraint in terms of this high level opaque definition,
> and not have to understand 100's of properties and their supportability
> across many hosts.
> 
> The same applies to non-guest host compatibility settings. I might be
> runing on a RHEL-9.6 host, but I want to have compatibility with any
> RHEL-9.2 host or newer. I can't probe QEMU on the 9.6 host to determine
> what is acceptable for 9.2. We need to be able to express that cross
> host compatibility as an admin, without having to list a huge set of
> individual properties.

Yes, maybe I didn't explain myself clearly, I believe we share the view.

My point was we shouldn't introduce special QMP commands to do set()s just
to work similiarly as what machine versioning / compat properties do.

I hope we will start to have something like query-platform soon.  Jason and
Michael have some discussion here, which should be discussing similar
concept:

https://lore.kernel.org/all/CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com/

Maybe USO can be a start point for us doing this, allowing mgmt to probe
host features.

Thanks,

-- 
Peter Xu


