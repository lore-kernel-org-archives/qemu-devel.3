Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA336EFCE21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpmN-0004sN-V4; Wed, 04 Mar 2026 12:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vxpmM-0004rn-BC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vxpmK-0007wQ-VQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772644375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pPVdzIIePuK+F2R5oJ7gn/ShMMHO/lKUzbK9XmaCfmA=;
 b=Ouv2rWj4khk3nLWIggajVGVChX92GluFORyRhOTt6qHTqAUf7mvS+vk8uYqchK8pO9YrPv
 u0mp//2JcPUoljbijpIMJa1GACrmXkG2T+11SI15r4pzWhvtCKi9bAxfEC8z0Ti2DD1lQS
 hDgMWWOZj7vEgI0TQrGa4EzewvY7mmw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-NxAxb6muPXKYw9aNY1myiA-1; Wed, 04 Mar 2026 12:12:51 -0500
X-MC-Unique: NxAxb6muPXKYw9aNY1myiA-1
X-Mimecast-MFC-AGG-ID: NxAxb6muPXKYw9aNY1myiA_1772644371
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b3011be7so2419725f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772644370; x=1773249170; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pPVdzIIePuK+F2R5oJ7gn/ShMMHO/lKUzbK9XmaCfmA=;
 b=VVOzvBcF52PgLQuwTXwZtdLmSdV4W1vSRXEGQ4wFOzOMisj5TXki3qofGWjADlXFBO
 Vo1aAs+KLvCtpvNPsOo9v2pkuVEKakq8IiN1V0omUGK3yle4Upqz4n9ze08nRyu5lfJY
 Ae1snuTgnR3D0ZMfPAFEU1iUa4OueNBUmwJsL8REk0aF4k4p3vao0wPq3qGxogGWVYxz
 wkiRojRbjw8GXmQYI54xr9PvXYob5WFdWj+wISnlHrHKOIpPrWLTZiu8gm1BuSVaB9Qz
 Sg8ru6yTYM+1L1SPIFcy92HbT0MIlf3IrxOLhe83QgmE0si6VxC950TFpYsMeRhSjycm
 aEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772644370; x=1773249170;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPVdzIIePuK+F2R5oJ7gn/ShMMHO/lKUzbK9XmaCfmA=;
 b=FfJnMZJ5YT1g+Y39D8T6KqsHO0w2/iRIIJUcT2hPxng/TR5VrzapJ4mdTC75FI5dQJ
 aplyzVkwSZnmgX57+YYf1oh3mvGyYNxGfTgnW9iiGaCuXXwuIGrikSo76ayS4us5HSwU
 pi5D0v/a378PwZ+h4Ckg6Aw7282Ar/GJI+zm7r8aEyZeBfLUMGwiedAZX8ocoBICIb5m
 RkSInjDWgZ71BpPgW7YNcqBcZFtiybqkZ3aF239s+tf1LWElqvWwnKq8H4BJ3mufEXio
 +bpfY9Ri2XEsYSs8kT6ooM0SdaBdC7XhR9TB6cWBsYayKCwkLQPbQWclxZfhplgZdILE
 sR2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeYSz2UXaB+8ddKW7clFI6rkaF5JphJLyrGjQIQ/Fp3C/QeazKVkf3N3XT8KUt201/px2lNNyK216g@nongnu.org
X-Gm-Message-State: AOJu0Yx7o8G7fBjbBbCTxdyfkRFrq/dOhdTteIEMjqHMTby2hfi/isZT
 sqNQL6aTqvyPDgiwa9hjBGm4zFODTGkF5jfPRrX0KdtgAqmkCftV6nbnUu3kWutCRf5a2qIwvnW
 ZIFebrd3LcnglvOwEeEPD0Zj6cdOk1aEKdWIyuWMsJ6k/TEM3UUYtsgxQ
X-Gm-Gg: ATEYQzwK0Kp4V+YKC9VoyQ977i0OfYEvVgraR0S00CMw3Zw0USb1PSLFASM9CwqxCc/
 Bo21Cbyw6MDtxaC5ARM5FppWJddq9cuzRFt/jIr7iluVOsNqrALYW76YKhZYYrghJ9rlsOaNccL
 Rh8pA3zVgaM7Dza7gUEOV2xwz9o0IJMXAazTlFAecCakdk51fHVJ+GIcXt+ubOxjZ4+86d0WnWn
 fhm7xgwOuMVVVvP4pkfJ0EHbAFI3zdCIdrKSHOTZ/MsY4LyLvHLFtxXcDr6NeBm7TSQCIBpothY
 nVJ7kJyLkaag74CpnLG5ZWP4GrGKeNnMMJgkmvNseSoKwW0gauPy1Q/a5n5NPHzBZykXUBIE6U5
 RY9R9G/haVmY1TOTMJGUtPZO+9IhDLx/1hfGwGkJtBibn2Sb8ClVJKcqZEz/5mD8pGuTR
X-Received: by 2002:a05:6000:26c7:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-439c7fe6711mr5293797f8f.50.1772644370627; 
 Wed, 04 Mar 2026 09:12:50 -0800 (PST)
X-Received: by 2002:a05:6000:26c7:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-439c7fe6711mr5293739f8f.50.1772644370109; 
 Wed, 04 Mar 2026 09:12:50 -0800 (PST)
Received: from rh (p200300f6af4a490003d6f56739ca055c.dip0.t-ipconnect.de.
 [2003:f6:af4a:4900:3d6:f567:39ca:55c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b41831easm27950931f8f.12.2026.03.04.09.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:12:49 -0800 (PST)
Date: Wed, 4 Mar 2026 18:12:48 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v7 1/7] target/arm/machine: Fix detection of unknown
 incoming cpregs
In-Reply-To: <20260302103640.1362564-2-eric.auger@redhat.com>
Message-ID: <e4025976-9200-8419-d533-8076de0174d5@redhat.com>
References: <20260302103640.1362564-1-eric.auger@redhat.com>
 <20260302103640.1362564-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 2 Mar 2026, Eric Auger wrote:
> Currently the check of cpreg index matches fail to detect
> a situation where the length of both arrays is same but
> - destination has an extra register not found in the incoming stream (idx1)
> - source has an extra register not found in the destination (idx2)
>  where idx1 < = idx2
> Normally this should fail but it does not.
>
> Fix the logic to scan all indexes.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: 721fae12536 ("target-arm: Convert TCG to using (index,value) list for cp migration")


Reviewed-by: Sebastian Ott <sebott@redhat.com>


