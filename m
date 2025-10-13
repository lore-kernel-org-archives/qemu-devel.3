Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09442CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HDp-0000wz-T7; Mon, 13 Oct 2025 08:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8HDf-0000pU-DT
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8HDX-0001px-FG
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760356792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXFfEhAlGknx8tM+C5EibTl3qhTHBRfmB0LsWweYTMQ=;
 b=H+l7FGqM+s09MwBTP1fTfqeAU7vkbLOeOaAgdsUWGD1VqbPzmjEg9wLtwNm1oXbcjdaNYN
 g+jrAM7qbp56x0d6OGibExUeL/9Yk0PYmZ3SdeYkGVjLnnN+mHUFL6S0+fQTpIN+mznAXT
 EKGISHIPv+cqjEg2juVoDXV13QxcdWM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-KCR11xF0NWW69f9t1zGX-w-1; Mon, 13 Oct 2025 07:59:51 -0400
X-MC-Unique: KCR11xF0NWW69f9t1zGX-w-1
X-Mimecast-MFC-AGG-ID: KCR11xF0NWW69f9t1zGX-w_1760356789
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso2931078f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 04:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760356789; x=1760961589;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXFfEhAlGknx8tM+C5EibTl3qhTHBRfmB0LsWweYTMQ=;
 b=JYEsaFJ0ELXBSFut6j2khSSTVAyLZ4fvRROjZSjFldMfF8DcRKugIqQ+QEc7rlez4D
 VD0ORZQLkM9PuvYkfumqkePDpL2kAj/fiIuxehaCeoqJcR4XJrf7zSJOz435GvwxlA4Y
 dzemcCAsbGjs7GPvvCKBUwiowKlTTiSYjgULaOXEsKiBrns6vExoHx+XjmPvsAGEeikQ
 7xkUVzz7MsLSOxzkjbu+qNgVRPnojlxo8rEKikzhsrVUO3WPUwBAizdxuTgUV+kGOdxj
 BaedcwKQTmPDHXO8bWhJcO1ngaE3pDrzzNYJuyQyXKn3vCD0iY5xw0zJiQGI1ijqyKRZ
 wHEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKI/Wb6HYsu3nh6+wLyQGox+rrtAtazkshccTu7qgo3BxbEOgoL2146PbFL/8zYKTs5ijpPpUTeUtl@nongnu.org
X-Gm-Message-State: AOJu0YzI9rvA2DorEujTbx5LIuDdCNZolwzyVA7RAtyBMC46+70y6jkC
 oFrBz41DjprCyzsTYOaR1IdvUTA6BKg+8THiI5pgY62cuP13d6OsN0nEOZ3fR/U6kT2JT5xTwNg
 xd+zRVyCgdUMLX7hVZ9r3n2tyTdkD+Sni9+6FBK+0/F2Cbddr7HIDGvd0
X-Gm-Gg: ASbGncvyV71DAUNX6YjIXfO4dAoDXbI8hYXsKCwKNqVowH7UIjjeDHT/14Nj7swD76a
 9fvnh4eneougXKuf30lvwan+YnMvrlf/U/5p60WmVxjU3vUscemjAD58VBBWOQ+Q6JeRNtYHHbU
 67+rMiSirgZYb7wsyckJXzCXGIuJaMCOh3edC80NpqEYgudXl8ElDFLE/ZWL740IXBUeWPbNwR4
 9GhjBa0wwmG0TnMmtLxBqon9gQ+qS7ha6TgiOUIdaOO8JSEl+bDGyKeCCJlAcqosv+qynKx0AY9
 Q27NK8v6HtnkmXkMN/vvAp9yMcHYl5cCcw==
X-Received: by 2002:a05:6000:18a6:b0:3dc:1473:18bc with SMTP id
 ffacd0b85a97d-4265ef6e3fdmr11535828f8f.0.1760356788664; 
 Mon, 13 Oct 2025 04:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsfqN2pYsPNpsFL+wvsrOR3n93Mnu0vUW78OYkQ6zqP7Rn5q55b7EmAHYHXhbROg7PrMw9yw==
X-Received: by 2002:a05:6000:18a6:b0:3dc:1473:18bc with SMTP id
 ffacd0b85a97d-4265ef6e3fdmr11535800f8f.0.1760356787996; 
 Mon, 13 Oct 2025 04:59:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4982c10sm178885285e9.5.2025.10.13.04.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 04:59:47 -0700 (PDT)
Date: Mon, 13 Oct 2025 07:59:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <20251013075817-mutt-send-email-mst@kernel.org>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org>
 <aOzm2ukHfkPF-zhT@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOzm2ukHfkPF-zhT@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 13, 2025 at 12:47:38PM +0100, Daniel P. Berrangé wrote:
> On Mon, Oct 13, 2025 at 07:12:31AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Oct 13, 2025 at 10:40:36AM +0000, Bernhard Beschow wrote:
> > > 
> > > 
> > > Am 8. September 2025 14:45:40 UTC schrieb "Michael S. Tsirkin" <mst@redhat.com>:
> > > >On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> > > >> Currently our security policy defines a "virtualization use case"
> > > >> where we consider bugs to be security issues, and a
> > > >> "non-virtualization use case" where we do not make any security
> > > >> guarantees and don't consider bugs to be security issues.
> > > >> 
> > > >> The rationale for this split is that much code in QEMU is older and
> > > >> was not written with malicious guests in mind, and we don't have the
> > > >> resources to audit, fix and defend it.  So instead we inform users
> > > >> about what the can in practice rely on as a security barrier, and
> > > >> what they can't.
> > > >> 
> > > >> We don't currently restrict the "virtualization use case" to any
> > > >> particular set of machine types.  This means that we have effectively
> > > >> barred ourselves from adding KVM support to any machine type that we
> > > >> don't want to put into the "bugs are security issues" category, even
> > > >> if it would be useful for users to be able to get better performance
> > > >> with a trusted guest by enabling KVM. This seems an unnecessary
> > > >> restriction, and in practice the set of machine types it makes
> > > >> sense to use for untrusted-guest virtualization is quite small.
> > > >> 
> > > >> Specifically, we would like to be able to enable the use of
> > > >> KVM with the imx8 development board machine types, but we don't
> > > >> want to commit ourselves to having to support those SoC models
> > > >> and device models as part of QEMU's security boundary:
> > > >> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
> > > >> 
> > > >> This patch updates the security policy to explicitly list the
> > > >> machine types we consider to be useful for the "virtualization
> > > >> use case".
> > > >
> > > >This use-case sounds reasonable to me. I also imagine that
> > > >some machines can get fixed down the road perhaps to
> > > >the point where they enter the "virtualization use case".
> > > >
> > > >However, since we are
> > > >getting this elaborate, would my old idea of a runtime flag
> > > >make sense now?
> > > >
> > > >To recap, the idea was to add a "-virt" flag that will
> > > >block any machines, devices and so on not considered
> > > >part of the "virtualization use case".
> > > >
> > > >We could also create a mechanism for downstreams to
> > > >tweak this as they see fit.
> > > 
> > > Hi Michael,
> > > 
> > > Thanks for confirming that the use case seems reasonable.
> > > 
> > > For now, we'd like to sharpen the term "virtualization use case" to allow for KVM to be usable in machines that aren't inside the security boundary and where maintenance commitment is unrealistic. The current approach is to adjust the policy and to spell out the machines where these commitments are made.
> > > 
> > > The trigger for this RFC was to be able to add KVM support to the imx8mp-evk machine. I have it working but can't currently upstream it due to our policy. It asks for unreasonable work and commitment which adds an unjustifyable burden on the maintainers.
> > > 
> > > I do see a need for further enhancements on the broader topic like adding a -virt switch etc. Maybe we should come up with a different term than "virtualization use case" which appears to leave a lot of room for interpretation. I propose these topics to be addressed separately.
> > > 
> > > What is missing for your R-b?
> > > 
> > > Thanks,
> > > Bernhard
> > 
> > rebase on top of this:
> > https://lore.kernel.org/all/20250926140144.1998694-1-berrange@redhat.com
> > 
> > if there's anything missing there, add it.
> 
> I don't think that its desirable to rebase on top of that series,
> as it is liable to unduly delay Bernhard's work.


Yea I'm all for not delaying imx8mp-evk work. Let's just find
a way without enumerating all machine types since
your patchset does it. This is what I meant, really.

> With a very minimal wording tweak our current defined policy could
> avoid being a blocker for enabling KVM in imx8mp-evk. In
> 
>   https://www.qemu.org/docs/master/system/security.html
> 
> where it describes the "virtualization use case", we could simply
> tweak it to always require a versioned machine type
> 
> Change
> 
>   "These use cases rely on hardware virtualization extensions
>    to execute guest code safely on the physical CPU at close-
>    to-native speed."
> 
> To say
> 
>   "These use cases apply to versioned machine types when used
>    in combination with hardware virtualization extensions
>    to execute guest code safely on the physical CPU at close-
>    to-native speed"
> 
> Since imx8mp-evk won't be a versioned machine type, it is thus
> trivially excluded, without us having to enumerate all machine
> types int he docs.

Sounds good.

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


