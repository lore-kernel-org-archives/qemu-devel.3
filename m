Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A104CD2C560
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3G40-00039d-4d; Tue, 22 Oct 2024 10:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t3G3y-00039U-T0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t3G3w-00008t-GQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729608043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXcWwIUZtnbf65R23ynY8kfuCwTv/uMUzYdX2/xtM3Y=;
 b=DbefZebrl8UIDc+qJASOzCfO8tGnuBecBOFRkEa474mkBlfsj1VqJBiCRIpI+6vpnJVCI4
 eMEXixppXgre0K6wc4iG/9/foFC/oWxt2K+O/+ytjzjqO1Og1AqwSFaReEeE4i/Y76hfI3
 lYAHSG6ftRroNsd2D6Olb6L43dcc1Uc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-37maMZyEN7yG9uo4jpQTAg-1; Tue, 22 Oct 2024 10:40:41 -0400
X-MC-Unique: 37maMZyEN7yG9uo4jpQTAg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539ec1a590fso4572263e87.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729608040; x=1730212840;
 h=in-reply-to:references:user-agent:cc:to:from:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bXcWwIUZtnbf65R23ynY8kfuCwTv/uMUzYdX2/xtM3Y=;
 b=G+OXmH46RcJl5FNCjYALUFQbs9hYeohsKCm1okiKQYQrnWP4FM+oGtyKVb7qpdnE3w
 l0fKG1yuHrg0MI8puE53Htr8TpFaG1vpRpND2zgMvMkFFSsuHzCtzuGdwNKIujG20268
 5SutHUYzxjWkUyHWL/kTYZkMNHkDVeNX4/BALJBDu8NzeICoernKR8pi1ShiLITPWxCi
 EnXljGe3KwRIe7Xhq+2z9UEQrFu/jbpWGRD/AdaOLqgKXBvioPsaLPdB1DhLdV4hVduN
 75CcLWMTQcns708XQwwB2niBfwyFPA6Z+W6S+yHTe1ssgF/czjuM/Walak2J3lNb1Wng
 WYog==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4On64YnPaTQrEttTaywKDpkJyqnl3S4OizRvtUGPFuxp+f8G3oITXmqaLVocdyiXJ114SdDGyqMFM@nongnu.org
X-Gm-Message-State: AOJu0Yy1FDgu9r07k0sWNOoL7fCW/g99pNp7KUlJ5Xt6jjmeVHytJ0T8
 u+hgasvBpKsFaV4SzplPZy1HVLF5xKhydthegz/hU7HIlFEQBIbu7tAAgTnD1OGG547hYkZGTlj
 2Eh5+HOs5Vag0L/PTvcGaXNUtSqom1w2nXRImcoEuJvxlaxbcRdIu
X-Received: by 2002:ac2:4c47:0:b0:539:e333:181f with SMTP id
 2adb3069b0e04-53a1520be3amr7354362e87.10.1729608040058; 
 Tue, 22 Oct 2024 07:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErUaAKszKnGCgo95T1kNrBhzF7dJkoiOmXUocHlp4mOYff/e1lBLpWSzcxFkh/ggCNbMoP4g==
X-Received: by 2002:ac2:4c47:0:b0:539:e333:181f with SMTP id
 2adb3069b0e04-53a1520be3amr7354335e87.10.1729608039506; 
 Tue, 22 Oct 2024 07:40:39 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57112esm91604395e9.6.2024.10.22.07.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 07:40:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 16:40:38 +0200
Message-Id: <D52EVNUBYM8M.3RUYANOJFL8NM@redhat.com>
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: "Igor Mammedov" <imammedo@redhat.com>, <pbonzini@redhat.com>,
 <mtosatti@redhat.com>, <qemu-devel@nongnu.org>, <vchundur@redhat.com>,
 <rjarry@redhat.com>
User-Agent: aerc/0.18.2-69-g1c54bb3a9d11
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
 <ZxelgDeuZaia-Vqf@redhat.com> <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
 <Zxe2tcMcHs6eYsp0@redhat.com>
In-Reply-To: <Zxe2tcMcHs6eYsp0@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9, Oct 22, 2024 at 16:29:
> On Tue, Oct 22, 2024 at 04:16:36PM +0200, Anthony Harivel wrote:
>> Daniel P. Berrang=C3=A9, Oct 22, 2024 at 15:15:
>> > On Tue, Oct 22, 2024 at 02:46:15PM +0200, Igor Mammedov wrote:
>> >> On Fri, 18 Oct 2024 13:59:34 +0100
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> >>=20
>> >> > On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote:
>> >> > > On Wed, 16 Oct 2024 14:56:39 +0200
>> >> > > "Anthony Harivel" <aharivel@redhat.com> wrote:
>> >> [...]
>> >>=20
>> >> > >=20
>> >> > > This also leads to a question, if we should account for
>> >> > > not VCPU threads at all. Looking at real hardware, those
>> >> > > MSRs return power usage of CPUs only, and they do not
>> >> > > return consumption from auxiliary system components
>> >> > > (io/memory/...). One can consider non VCPU threads in QEMU
>> >> > > as auxiliary components, so we probably should not to
>> >> > > account for them at all when modeling the same hw feature.
>> >> > > (aka be consistent with what real hw does). =20
>> >> >=20
>> >> > I understand your POV, but I think that would be a mistake,
>> >> > and would undermine the usefulness of the feature.
>> >> >=20
>> >> > The deployment model has a cluster of hosts and guests, all
>> >> > belonging to the same user. The user goal is to measure host
>> >> > power consumption imposed by the guest, and dynamically adjust
>> >> > guest workloads in order to minimize power consumption of the
>> >> > host.
>> >>=20
>> >> For cloud use-case, host side is likely in a better position
>> >> to accomplish the task of saving power by migrating VM to
>> >> another socket/host to compact idle load. (I've found at least 1
>> >> kubernetis tool[1], which does energy monitoring). Perhaps there
>> >> are schedulers out there that do that using its data.
>>=20
>> I also work for Kepler project. I use it to monitor my VM has a black=20
>> box and I used it inside my VM with this feature enable. Thanks to that=
=20
>> I can optimize the workloads (dpdk application,database,..) inside my VM=
.=20
>>=20
>> This is the use-case in NFV deployment and I'm pretty sure this could be=
=20
>> the use-case of many others.
>>=20
>> >
>> > The host admin can merely shuffle workloads around, hoping that
>> > a different packing of workloads onto machines, will reduce power
>> > in some aount. You might win a few %, or low 10s of % with this
>> > if you're good at it.
>> >
>> > The guest admin can change the way their workload operates to
>> > reduce its inherant power consumption baseline. You could easily
>> > come across ways to win high 10s of % with this. That's why it
>> > is interesting to expose power consumption info to the guest
>> > admin.
>> >
>> > IOW, neither makes the other obsolete, both approaches are
>> > desirable.
>> >
>> >> > The guest workloads can impose non-negligble power consumption
>> >> > loads on non-vCPU threads in QEMU. Without that accounted for,
>> >> > any adjustments will be working from (sometimes very) inaccurate
>> >> > data.
>> >>=20
>> >> Perhaps adding one or several energy sensors (ex: some i2c ones),
>> >> would let us provide auxiliary threads consumption to guest, and
>> >> even make it more granular if necessary (incl. vhost user/out of
>> >> process device models or pass-through devices if they have PMU).
>> >> It would be better than further muddling vCPUs consumption
>> >> estimates with something that doesn't belong there.
>>=20
>> I'm confused about your statement. Like every software power metering=20
>> tools out is using RAPL (Kepler, Scaphandre, PowerMon, etc) and custom=
=20
>> sensors would be better than a what everyone is using ?
>> The goal is not to be accurate. The goal is to be able to compare=20
>> A against B in the same environment and RAPL is given reproducible=20
>> values to do so.
>
> Be careful with saying "The goal isnot to be accurate", as that's
> a very broad statement, and I don't think it is true.
>
>
> If you're doing A/B comparisons, you *do* need accuracy, in the
> sense that if a guest workload config change alters host CPU
> power consumption, you want that to be reflected in what the
> guest is told about its power usagte.
>
> ie if a change in B moves some power usage from a vCPU thread
> to a non-vCPU thread, you don't want that power usage to
> disappear from what's reported to the guest. It would give you
> the false idea that B is more efficient than A, even if the
> non-vCPU thread for B was cosuming x2 what the orignal vCPU
> thread was for A.
>
> What I think you don't need is for the absolute magnitude of
> the reported power consumption to be a precise match to the
> actual power consumption.
>
> ie if A and B are reported as 7 and 9 Watts respectively, it
> doesn't matter if the actual consumption was 12 and 15 watts.
>

Right, my bad, I agree. When I said "not accurate" I was indeed talking=20
about the absolute magnitude of the reported power consumption.=20
Like your example above is what I had in mind.=20
Sorry for my clumsy shortcut and thanks for clarifying this important point=
.


