Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BA7E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 07:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYJwV-0004gS-3n; Thu, 16 Jan 2025 02:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYJwR-0004er-PR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:05:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYJwQ-0005tW-1H
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737011113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbOrTLBnztBZMpBgK6mWrolAzWbd5PyfmHB2jNTOcHQ=;
 b=RONN4/5pwsqCC62zZvmBqFPgtuP93VuKALIcOueMXEnmxBEzjoJSv+IRxzsuerLpUU/fZN
 F8gm6C4C3o0EqxSzqPk6mFQ2fMPCe0jvRpUXIFvXhZBgEu1EFlX6Bta3w+mgL9nysgeR/0
 d0eeJDX7ShHBye+suVqbuf2RIHG8eZc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Z-N6spn6MgGhMgkt20k6RQ-1; Thu, 16 Jan 2025 02:05:09 -0500
X-MC-Unique: Z-N6spn6MgGhMgkt20k6RQ-1
X-Mimecast-MFC-AGG-ID: Z-N6spn6MgGhMgkt20k6RQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43651b1ba8aso3185435e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 23:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737011107; x=1737615907;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gbOrTLBnztBZMpBgK6mWrolAzWbd5PyfmHB2jNTOcHQ=;
 b=kZhnfV93w/aT5b0qr5aEuddRHKYxWTjek/uD/DcTFt7WvHFNkqnN7Gny6sxxCflBRe
 evJk4S8fErRCWoLXyd1UCU68/0dfyxsrKvyaADRw5842W6Bk2RHUYnsg1naAbriRLz35
 cQXtEfLk8Zebe2RKoYYbsiWWPWSHo7zYKYazvQ8/AuSd8MeFXqNLM5iumzYLkBJeppXW
 k6NC3bk4iZs20u9xL5IsEfGjPRasKznry7dtTXyAtZB8XrkTljY1yMEt8ge0Q37qeZHo
 UZren3wWKf3WGPPKLXSZBuUMesNkNd3vLoEsXClpLZnK68uu4LPBOGIONPfs7rPwHpJm
 rgRQ==
X-Gm-Message-State: AOJu0YwgnmCnSyD4iLYZSr+Oyz6AxfPVjK1U55iIRuIAgczIFxHWXNE5
 vpFMfLvxaXyagucT/Yn4uGRWsfOeILN77Lqv08dHLNbeJd8LBCbpkXFzUq/AdPtLEjYxd1jftMO
 TNt/d3uZN1xkAfYRl7mRT8Hg7ghJRu2OWYMn+3FY8pdSbSMnWbhOl
X-Gm-Gg: ASbGncuQUhroQnAISHFTj+z/Sgn9fUzq7eNPhXuO9fGRdb2dB4PC/j52OfJB1QrqdgB
 OLaGI1ydOBMDOGPrkEy30YPkNrA8YxXSvIzHnAyE/7qhB/0D++cphEDeQIuXSoQSwq6O5FnX5gT
 y0HZEp7iGSJI7Avr/K8zEeYLFdd6oRe/6HEcYlrWQXdVD/HjejGfaMu055+S7xSozyuLNRp/XPb
 L+BwKaGO+JVorY1ZIMkpm2M1gpQ3jqB2YTJ80rGK8VpMa2cej53
X-Received: by 2002:a5d:64e9:0:b0:385:f7d2:7e29 with SMTP id
 ffacd0b85a97d-38a87304221mr30931238f8f.15.1737011107289; 
 Wed, 15 Jan 2025 23:05:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqmsCbnb5bpxwkDe8Xy0EJBrTq0BcnobDgmNI062VkE+70jasCyPrn41kh585Z0dJi6h7o3g==
X-Received: by 2002:a5d:64e9:0:b0:385:f7d2:7e29 with SMTP id
 ffacd0b85a97d-38a87304221mr30931187f8f.15.1737011106903; 
 Wed, 15 Jan 2025 23:05:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0bdsm19486030f8f.3.2025.01.15.23.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 23:05:06 -0800 (PST)
Date: Thu, 16 Jan 2025 02:05:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/48] virtio,pc,pci: features, fixes, cleanups
Message-ID: <20250116020413-mutt-send-email-mst@kernel.org>
References: <cover.1736964487.git.mst@redhat.com>
 <4f0312153b3232dc25afbb3901f00a3c53465074.camel@infradead.org>
 <20250115174130-mutt-send-email-mst@kernel.org>
 <E43462B5-CFB5-433F-BB70-BEDC8D2FD4F2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E43462B5-CFB5-433F-BB70-BEDC8D2FD4F2@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On Thu, Jan 16, 2025 at 12:05:59AM +0100, David Woodhouse wrote:
> On 15 January 2025 23:42:41 CET, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >On Wed, Jan 15, 2025 at 07:15:18PM +0100, David Woodhouse wrote:
> >> On Wed, 2025-01-15 at 13:08 -0500, Michael S. Tsirkin wrote:
> >> > The following changes since commit 7433709a147706ad7d1956b15669279933d0f82b:
> >> > 
> >> >   Merge tag 'hw-misc-20250113' of https://github.com/philmd/qemu into staging (2025-01-14 12:46:56 -0500)
> >> > 
> >> > are available in the Git repository at:
> >> > 
> >> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >> > 
> >> > for you to fetch changes up to 60f543ad917fad731e39ff8ce2ca83b9a9cc9d90:
> >> > 
> >> >   virtio-net: vhost-user: Implement internal migration (2025-01-15 13:07:34 -0500)
> >> > 
> >> > ----------------------------------------------------------------
> >> > virtio,pc,pci: features, fixes, cleanups
> >> > 
> >> > The big thing here are:
> >> > stage-1 translation in vtd
> >> > internal migration in vhost-user
> >> > ghes driver preparation for error injection
> >> > new resource uuid feature in virtio gpu
> >> > 
> >> > And as usual, fixes and cleanups.
> >> > 
> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> 
> >> Should I be concerned that the vmclock device isn't in this PR?
> >> 
> >> https://lore.kernel.org/qemu-devel/20250109080033-mutt-send-email-mst@kernel.org/
> >> 
> >
> >Oops.. it was there :( Dropped by mistake in a rebase.
> >I'll redo the pull, thanks!
> >
> 
> If it's easier, I could just round it up with the pull request I need to send tomorro^W later today anyway?

Yes pls do. You can add:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but, I noticed checkpatch warnings:

3634039b93cc51816263e0cb5ba32e1b61142d5d:89: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
3634039b93cc51816263e0cb5ba32e1b61142d5d:366: WARNING: added, moved or deleted file(s) imported from Linux, are you using scripts/update-linux-headers.sh?
3634039b93cc51816263e0cb5ba32e1b61142d5d:366: ERROR: headers imported from Linux should be self-contained in a patch with no other changes


Please address.


