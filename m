Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F83FD45EC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 20:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvLab-00058b-W5; Wed, 25 Feb 2026 15:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vvLaa-00058O-Iv
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:34:32 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vvLaY-0002Zm-Sy
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:34:32 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-503347dea84so1304051cf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772051669; x=1772656469; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tN6PjRL/ZwS4XuOMQRIPiesVTAQtFk8QgqFdcsKKboI=;
 b=AZ+QjCmnaNhRZAnTvrFTnYFB/XmZtUXOpNVaLvhRnIeBJ4s5339/wDEejj+QUe+Ndk
 g1ZW/wJuJ+F3Tk+mmtbid7zKunAQFUrH3RE07Wkbr+KShAv2DmzEVDL8tAymtnUBlSIZ
 8ic4K3oXmSZKT9WOK2Urmo0Z6/1pMahwoT1wbnxLBmfVQcrbN/LxjcZ610Pp3MzrMTjT
 k/h0TezViQk1ctTkMcLp3C39yXPFiwh8Tq4rJ7S5b5GfWEsKZ/OUn5dHe25kSkZvOOvH
 ktMESgKgUR2sj7qCrQraLNMvvHTWXzcKMAtG2ok8ycdYkftjlUnGJRU5ImWd+vzzi3Br
 5Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772051669; x=1772656469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tN6PjRL/ZwS4XuOMQRIPiesVTAQtFk8QgqFdcsKKboI=;
 b=cNpPeEQd/dG5R8E34PqY3/0c2oeb0kKewsjGQ/o57zCxvhUrhX2/pH77hfMlSp/gIM
 qqnIr98n+UldCgtBiCdyso7b7jkXw4QpmoJ245zDOoEL4RTKP2PzoWoKj+STYPKXEP2v
 cm7onVkPFGIDrplZZXT1uxhNVT2Cx/AGYLCf7WzY+kJ81wybcb9tD+CVZTy5g5fZ41ni
 0NRG3qHxqiGw1GtePgMj93ycY0ns/8JRIQ/ukJHhCmlijmRMOZkhBX+q51OTuzbNA9Zo
 nEpKBUrc6+ciq9saUm5KhPM80rAnTfrl9HFKSfXyJr8P0DB8R5KikLcjoRcX6snnIfZ3
 8BKA==
X-Gm-Message-State: AOJu0YwmKcxTFykt5H4lgUaJ/DUSGcwPB9L89sbMpZ4C2INYjol5Uv2b
 MPDYKqQTS2MZHXpnrpjigL6CYcOwoiZTkwnv+HybNKIdDu/3mEmzbSxKth2K/mBZ5dk=
X-Gm-Gg: ATEYQzwGOl7sM3UpP7fpeF77WIGIa65LXJ7GDPDuGfGVsveSRHmMMNWxbNpHW1dNIF8
 9MMAZ7ISok/CaOlhDLET+iinu9xoqP5KoGeWITE/3JMkNaez3mmWykrzVcGBTG6wPksZkjT/wbp
 fmSGWA3izNKg6nLknXGfnJab5m1ZRMfxgu1V2Vlg1WamjtjbSAIdP6wM6UlP4ovcF7MTrHMjDiW
 eNN1BBDy8ujj7fG487HFA3imoR4Q1sZVwupEw412yVxLMFm9x+Ah8B/ECM8jz80eHo3gGt2l/hN
 6nK8L+NopejfAtol6yo4g25F3Mh/CuWG50qAe4OpdSDuoJ2Nbj7C/Mbjj8aOwAklkNZ+TndnOrK
 KNzCCw2MubNFSO5WyM8TAqKtX0qHpS47rtUqsYTf021a3ZC9lpCnsmEAO8AGk0x0C9QkbqM9QXd
 CI9gNgoNn6NmMSuwt1P8LjN1Xm2Z7RhVTC4ZGx3V9byEKOXS8PE7G/cVOUpayPFfRM4KBNXtT7U
 PGUtCQzug==
X-Received: by 2002:a05:622a:1651:b0:506:9fd8:f65e with SMTP id
 d75a77b69052e-50741fc03dcmr24336611cf.60.1772051669537; 
 Wed, 25 Feb 2026 12:34:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744acfcdesm1567281cf.26.2026.02.25.12.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 12:34:29 -0800 (PST)
Date: Wed, 25 Feb 2026 15:34:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisa.su887@gmail.com, armbru@redhat.com,
 david@kernel.org, imammedo@redhat.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, lizhijian@fujitsu.com, mst@redhat.com,
 nifan.cxl@gmail.com, peterx@redhat.com, philmd@linaro.org,
 ppbonzini@redhat.com, venkataravis@micron.com, xiaoguangrong.eric@gmail.com
Subject: Re: [PATCH v5 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <aZ9c0yYcvKf5a0j7@gourry-fedora-PF4VCD3F>
References: <20260225180718.480-1-alireza.sanaee@huawei.com>
 <20260225180718.480-4-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225180718.480-4-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 25, 2026 at 06:07:18PM +0000, Alireza Sanaee via qemu development wrote:
> +static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
> +                                               uint64_t decoder_base,
> +                                               unsigned int idx)
> +{
> +    CXLFixedWindow *owner_fw = ct3d->direct_mr_fw[idx];
> +    MemoryRegion *direct_mr = &ct3d->direct_mr[idx];
> +
> +    if (!owner_fw) {
> +        return;
> +    }
> +
> +    if (!memory_region_is_mapped(direct_mr)) {
> +        return;
> +    }
> +
> +    if (cxl_cfmws_find_device(owner_fw, decoder_base, false)) {
> +        return;
> +    }
> +
> +    memory_region_del_subregion(&owner_fw->mr, direct_mr);
> +    ct3d->direct_mr_fw[idx] = NULL;
> +}
> +

kreview flagged this, seems reasonable given other examples in the tree

The other commits looked ok, I'll try to get around to testing this soon.

~Gregory

---

Reported-by: kreview-8842242

The alias parameters (target MR, offset, size) are all guest-controlled
and can change between cycles -- the guest can reprogram DPA skip, decoder
size, or decoder base before recommitting.  There is no API to change the
alias target (mr->alias) after init, so an init-once approach would not
work here.

The VGA chain4_alias in hw/display/vga.c handles the same situation
(embedded MR alias rebuilt with different parameters on guest register
writes) using object_unparent():

    vga_update_memory_access() {
        memory_region_del_subregion(s->legacy_address_space, &s->chain4_alias);
        object_unparent(OBJECT(&s->chain4_alias));
        ...
        memory_region_init_alias(&s->chain4_alias, ...);
        memory_region_add_subregion_overlap(..., &s->chain4_alias, 2);
    }

Adding object_unparent() in remove() should fix this:

    memory_region_del_subregion(&owner_fw->mr, direct_mr);
    object_unparent(OBJECT(direct_mr));
    ct3d->direct_mr_fw[idx] = NULL;


