Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A82FC5AD44
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 18:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtUpz-0004yS-D2; Fri, 20 Feb 2026 13:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUpr-0004vg-O3
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUpq-0008BF-6i
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771610557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wic1fOQ9KppcMP2fXZlA31RiRb2+CMIRd1ezuXkA2vk=;
 b=gqU2xHzqjUjHjHoiRnymRjaCUG5MddRiG1Rcre/LvTgO/OuNCVnkEHzhYmLDNy6E3y6ERy
 gequFbt3y/LyMeMuCZVQ1GzvxVEU/jMkGik52JpbmuHOV3aoyp/JminL0+AyvwXdhSlWoc
 gpyvqyu2eZYZiJKr8GN8Ga1bMPF0csM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-M8avijM2P5e9g2PkkVJehQ-1; Fri, 20 Feb 2026 13:02:35 -0500
X-MC-Unique: M8avijM2P5e9g2PkkVJehQ-1
X-Mimecast-MFC-AGG-ID: M8avijM2P5e9g2PkkVJehQ_1771610554
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so13278065e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 10:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771610554; x=1772215354; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wic1fOQ9KppcMP2fXZlA31RiRb2+CMIRd1ezuXkA2vk=;
 b=HSpvyOuBXM1j3GK4mMSYa0fUUFAf2nkVEOczAD5UWV+nyFqXZ5xQYPD34TBGq8Avpm
 C7zu0hg/V2NaDsoA5IXeVcJODfCMwOmUwY/vY2xW2sWJMUXKYH5vslCfNzBgcF5gliIO
 YKE/kKesLmGusQO1VVoDtTU9f3rNOWlzWwEmvIeE6TH2zGGyUQMztyvbRvYMn8777+VN
 8oeRJTnxh400NUrBAt9QfXqrZD/AZFDNWQ5Nx7rIc1et1Qw7+CRjGfi0AMDetaqwPOXX
 X8Z20121W6VgxOHXb1ySNU9q+PCW8mLC/BJ7HsfhFLQ+CPlU5RWAFCGZWquvDZW7jUbX
 cQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771610554; x=1772215354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wic1fOQ9KppcMP2fXZlA31RiRb2+CMIRd1ezuXkA2vk=;
 b=f8zyp59/Nal+h99y9CfXm2lzEuv2qsVNySI/kxmqcn+E3prjIYWLq7XgbR3th2xdbp
 WUZ4nU5m6/k4z3EHizLFNODazlckWB94lKV/Y0iW3pzFBNWp6upFJmkQM9NVSrbfFSX7
 JzXSqMuu4pLCbAb89GExjt9IJhfDtq/3j7AcBmdB2pM4NrEpfTjc7RNIPjSFAib1NE5H
 FB07bYxjI5WptjCocrcbcd5ICKf7fPDPpMl+hJJ3wOpz/g66zjed9DtoPXwtfGsY+Mx6
 Jl2NmlChif57dHgC3VLJhpU8PheofYXqeLmGN/oMSTSwguRbKyC7kdMFenZdoINxpt6h
 NdBA==
X-Gm-Message-State: AOJu0YzitW13M3+pMDMGFZgCP5yyoJ9esIfH1kgxT4FrvKfWPDNHSLhl
 620uIDSrONgge/jK/keikW7hy18HjkJYTn2h906v+DsWU+B+jbnxnW9qPMR+0tN5x77jOqbWTUL
 l3ss7NliL2EPgYDNuxxlbXI+0pgpyzLB3yI1wu+DmGZ5HXNBSYdlbsqCg
X-Gm-Gg: AZuq6aJHPPBrrQW/7s/FeL0kHr6tDPoZUv8XqlecjwOjx24Szhlp/IYpIh976JDb2vK
 eDG7rid6dQIjWxp9/OxfSd02HeZKN5q/lesZAc7jf8nVnsKJP+DsF2iPbyJI0yi3/L9PCTOWeDc
 WsmwYWi+ync46ppZz1zBFuPvSn0MeGz3HNxGd/inuGkVCR+KXszEpYBveYMr9GKS/XNWmrCSiZI
 yb8Y06C2Ny8PsxbcHtnlJTRmY9eqftbff6qf5FfMIlZyfYdbseuMuctw/xfxmwd6OGq1/BTG5qI
 6qtZHdWDaA9mrEmRoh5jjgjIntyXeTGaiXt0er11XlaGyvB95ONyOQfH4VE1Aribi8l0lHScGrU
 chzGNQLWHLWSmrEuvnf96HKATeutvm21BDKUlZj0o0KvsEQ==
X-Received: by 2002:a05:600c:8107:b0:483:103c:b1ee with SMTP id
 5b1f17b1804b1-483a95c536dmr5918015e9.8.1771610554111; 
 Fri, 20 Feb 2026 10:02:34 -0800 (PST)
X-Received: by 2002:a05:600c:8107:b0:483:103c:b1ee with SMTP id
 5b1f17b1804b1-483a95c536dmr5917305e9.8.1771610553549; 
 Fri, 20 Feb 2026 10:02:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5b07fsm58966639f8f.2.2026.02.20.10.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:02:33 -0800 (PST)
Date: Fri, 20 Feb 2026 13:02:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 11/13] scripts/ghes_inject: add a raw error inject
 command
Message-ID: <20260220130208-mutt-send-email-mst@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
 <8a8d1f55bc592c8f367fe948d4954dfefe59253d.1769175070.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8d1f55bc592c8f367fe948d4954dfefe59253d.1769175070.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> diff --git a/scripts/raw_error.py b/scripts/raw_error.py
> new file mode 100644
> index 000000000000..f5e77bdfcead
> --- /dev/null
> +++ b/scripts/raw_error.py
> @@ -0,0 +1,175 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=C0114,R0903,R0912,R0914,R0915,R1732
> +# SPDX-License-Identifier: GPL-2.0

GPL-2.0-or-later


