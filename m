Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE5ECD9AA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7UH-000620-4Z; Thu, 05 Feb 2026 17:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7UF-00061n-1W
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:06:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7UD-0000Ob-0I
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770329162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCaHs4n4OgqhsvJRU5NHZTr3lar61rWPOZfyIck6qn0=;
 b=MdQBVgpci54LSOmHG1DYXc7ma0tlxJ8WAOLvPfXI0pLEVewFXMoTjRQkCdqjrY5UN9eib8
 SDuwy1WeW4Mg9Z1oFMFLS/Oy4fWZ/m2vyknyNk9HUsOnUZlSDrlZJ0A5mk81mOF3xwJD/r
 jOF605uZnWMmbD7g07/HydDn3YBTP64=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Q2f7XDnhOdatV8_BOV5CDw-1; Thu, 05 Feb 2026 17:05:58 -0500
X-MC-Unique: Q2f7XDnhOdatV8_BOV5CDw-1
X-Mimecast-MFC-AGG-ID: Q2f7XDnhOdatV8_BOV5CDw_1770329157
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-502b155a742so51811541cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770329157; x=1770933957; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wCaHs4n4OgqhsvJRU5NHZTr3lar61rWPOZfyIck6qn0=;
 b=O3+tfBFtENaOF9elLevrZ5tPhWduqWVWjH4uB9c6sC2OOVzr/r6e6gKdZgJwN7f3h8
 /proBKOXtcE5y+eNO9EL9NBPFzVkg+5Lr+UK5imXPZnoe49I4tZdwp2Hk54NqTSWlQwp
 ziBr2rU56cLTs6YWXlf/qqh0ZV4st34iyDAnfYDs3JIZKrqc+LofDOcaBAf0wNL2mlBY
 eCIFcO9HzUksJaGrSQx9ti3wvU8TSbMGsJibx/Ndd+LPdLme7QfFc4JTO/dqoTuLuI8w
 ET7MKhTZnuIsPZOrU4bwOUIb5HYOMMSCPoq2vfHtB2wi7C2/0ne7U5Uspl4efqHuybtQ
 5JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770329157; x=1770933957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCaHs4n4OgqhsvJRU5NHZTr3lar61rWPOZfyIck6qn0=;
 b=apHtEc+js09qbHFkGVC/l1LGaGAKpUZ2Twlk8LH1PMZ7LzwLrWwT9ChhjKh8pl422Q
 o34+IrkQelVPHpjXvwbwEjIEqyRgtJGMYcIVXAb7QrXTtr48bprP93/u9XsTcUmJw7WJ
 +rt5tTp8W7SzYrWS0LdgdW6HGjDL3Bm7cB7XzRSarMQJ3Ai4L2Mx8Xubgmh3heRDpZPj
 AUvlVPaFTA7pTg1qlBJCmYscojJpX1PDPzRH+FtU7Ol14/THWHTTlR2ZGsGdZ0x01hbN
 iGw5S/RQgrRZvLfbajNji0wFic+H13T8PVyyp/kgjpLz0stPrOtAXif/F+iiQKf1hnYk
 sxjA==
X-Gm-Message-State: AOJu0Yzh7BVTi+K70+N4oUkhi3DjxN5x6oaavWtp9bONFtzUYzZEPD4g
 iNEJ+Shb63MMbF8k34v50cz16LfPO2tmx2ZnMqxK6NAK6OvfWyMYzCGObrH6RgqkifGmFKK7lNe
 l0uIQzfj91QZQFhQePueJTjUuuAcXrqYL/DkAWwTbtjrvx3QHH+crjUpd
X-Gm-Gg: AZuq6aIeJ762xGfhPyg6OgkuzhyxirrXGks/7S6MmlgNsJZPpkth8mq0JuiBcwc6bKz
 l+vTYLJNt5UHDtYRLLx27rriOk2SlRISRVFHjJWB4HDn9a0ZWdpdiRQL9A21NWdpC4CGDSpZ5zS
 3BfqHlChMQN8jqij2qKTAS7lP+qmdLTTQPymRPSqCPjCyaUGZkgQHkLNREDauBFOtqPkaqnyLTm
 IcbEfg/7kAIikGVunsQYE0osK3xEfoqocRdHx4JtkFOwcGZoTISbTw/vqqP9Kif2Tk783yssO/0
 CiL8suMqkObv8YqIqIFp6DcpH31jAUrkg53Rr5NaSTecwncnooye+wrNcLcWC1bzCsZBpo2Bn4B
 fums=
X-Received: by 2002:a05:622a:1486:b0:4ee:87a:4d10 with SMTP id
 d75a77b69052e-50639a23566mr9428921cf.78.1770329157188; 
 Thu, 05 Feb 2026 14:05:57 -0800 (PST)
X-Received: by 2002:a05:622a:1486:b0:4ee:87a:4d10 with SMTP id
 d75a77b69052e-50639a23566mr9428411cf.78.1770329156683; 
 Thu, 05 Feb 2026 14:05:56 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf71f53sm5572896d6.25.2026.02.05.14.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:05:56 -0800 (PST)
Date: Thu, 5 Feb 2026 17:05:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 0/9] qapi: Use visitors for migration parameters
 handling
Message-ID: <aYUUQ5sAiwR-nvul@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202224101.20568-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 02, 2026 at 07:40:52PM -0300, Fabiano Rosas wrote:
> Hi, just a few more patches until options.c is fully using QAPI_CLONE
> instead of open-coding options handling, we're almost there.

While I'm reading your series, I found one thing that migration might be
racy against for a while, and this series should enlarge that window of
this issue: I don't think it's safe to free elements in MigrationParameters
in the main thread, even if we hold BQL. Because migration thread can
access parameters anytime without BQL... logically it can read any
parameter, then if it's not a scalar we need some luck not crashing.

IMHO we may need to move faster on the "whitelist that can be dynamically
set during migration" plan on migration parameters and capabilities.

I don't think any cap (after converted to parameters) should be on this
whitelist... for parameters, I'm trying to be conservative but I believe
the list should look like this:

CPU throttle knobs:

        throttle-trigger-threshold
        cpu-throttle-increment
        cpu-throttle-tailslow
        max-cpu-throttle
        x-vcpu-dirty-limit-period
        vcpu-dirty-limit

Bandwith knobs:

        max-bandwidth
        avail-switchover-bandwidth
        downtime-limit
        max-postcopy-bandwidth

COLO knob:

        x-checkpoint-delay

That really should be all parameters we allow to change..  Luckily all of
them are scalars, so it's fine to keep the current migrate_params_free()
and logic to "free then update".

I wonder if we should even consider having this whitelist alongside with
your this series if we want to be extra safe, but I'll let you decide.. I'm
also OK we do it later, but maybe we don't want it to be too late either.

-- 
Peter Xu


