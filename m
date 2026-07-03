Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E91C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wffVo-00041g-Vw; Fri, 03 Jul 2026 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wffVn-00041K-PD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 11:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wffVl-00071M-Iz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 11:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783091339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHZM3FtystwE8RdsHLA5NeuVGl3VQ3qLy6oASpCeJkU=;
 b=YIOYWIlerXWp44Z/g7bjc1p6Hfx6qNfZnRpU8a+o6b596ALuQvYlu7E8Rb9GbydXeb+KcO
 hJCGh/NaXhbZnm5OdQTXJTJO9Uihcn1DExZWnFYFCu03GV6v3F7m8IhRi0E/cnboiyoxAj
 eCIXzKA4GKZfkap+lgh/U1wxrLW0S10=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-x5pr8eYRN2S-BBkT1T-tsw-1; Fri, 03 Jul 2026 11:08:58 -0400
X-MC-Unique: x5pr8eYRN2S-BBkT1T-tsw-1
X-Mimecast-MFC-AGG-ID: x5pr8eYRN2S-BBkT1T-tsw_1783091337
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4773d2405c5so665219f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783091337; x=1783696137; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LHZM3FtystwE8RdsHLA5NeuVGl3VQ3qLy6oASpCeJkU=;
 b=ZACzHhb8fabKjx1XcSR3+hNNzDsj9oD2qgDRO6jnWCFYthNC8waBk9uOXAHvqNYaFa
 JB2xIMagzSohKsmVlLwDAjGxp4U6ClkWDdBtIrMp/XBnP3dCxxmyIxT7y5VFPCRp3bP3
 jt9arAOgGFa8rd+UQXVsMO0Eq+UGUa6cle1zp8gzJjDOX5Kp+x4Uj0+e+YHudTESPdT2
 WTv2rQEbDMwPvNqplSCiyQUTxsjJ9fcq7UIHVVvaBG3CNr2WpnvyyVZxs/RgNG970Im/
 kaT1CpRGd8yUXi2BIHgSpwQ55dZgTVXlC0JPxh1AwKoGWmcJ3wqchXVjy+E0u8PN7zK5
 ZbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783091337; x=1783696137;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHZM3FtystwE8RdsHLA5NeuVGl3VQ3qLy6oASpCeJkU=;
 b=EZ4Ydu5CRSRGcf+neaDG+BR9k97AOJZZg5EbSLKpayzx1qjZBK257/VFSpUdlEP/tv
 ZKvxkvAvuy9d/UC3Udxkz7Ewj65j1XDRKY8hmsEOnlk3AAAIf/cQ7iXQFtW6D7NnoCSB
 f4xAPrkT96IfbYB5Qwf2pXtuxpkS2J155/HVicY8KfyPFWYT4XHEBpjKhoSP/01hsQpE
 IbD3pOON1sdY7kqL3IATg8E1EYao1hpMsaiHXyH/H5HkkKJcS5Ojtj5olDikXnVlxn2S
 7vm2LufDXxRKk6ScvSV4BgNlI0Ko/H3shteqXNW9S+bLxGJs+J+W98IRmQwX97yTmy0I
 Hl0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe/NhYkRYY6qfJXsO4+avPJrNNTPG+tq34CYxizky5pLTRYIUR+nGP+Z8/fVpTlWAaw/Wg2AAla3p2@nongnu.org
X-Gm-Message-State: AOJu0YylQnCoswP61cB+fNEIuSIMC3iJHUjhf1EMagg8ieLW41N9LHWq
 FiDAkiHDdoeNWEKtZFf2o66KICb36U8rIIkC77g7A4/82NVDVZ+U2SIGV4AfBIBWdGMkF6i56rV
 xT4sV6kZ701zg3ZmJ6YZ95Qe53oSDTHrlTPt2SX1BoLmIlkD7mm+/5pq/
X-Gm-Gg: AfdE7ckRVxOaz02p9nzEimcXHieC2Na5YDaCYzw6yjI/bDgC9k6+9zpBss8ytPgIvXP
 UV9TeOIdBbgjzdGupi9re8ariLUxyw5K2AFLeIJI5y0gsWaQizeqGxKFjLlDgIzs22ESIaa46tf
 89CurNJmDo0+1udtizQqxNB65oJp5fOEr1szdWtuOGKLkKYWnqzrWWReOFVt6yynwrygcW4RepW
 DAr6S5DBcrmhmYE+5WmdJt6ZrvMlMfN8tdJOcD2OsqADrJPHrCi/YgvoOThK3z5h/KtyD7u5kDb
 4EIzXd22eAlb2HVcf3YgW9hyKGd31twqu6YtVduu788ln297THTjq7+gpxNRrmhpxqwyziVEKMf
 4mpeqioLskuIHKlFwTAladDPBjFMw8KOV
X-Received: by 2002:a5d:4906:0:b0:476:681c:4642 with SMTP id
 ffacd0b85a97d-4775c4be0e2mr12303186f8f.44.1783091336719; 
 Fri, 03 Jul 2026 08:08:56 -0700 (PDT)
X-Received: by 2002:a5d:4906:0:b0:476:681c:4642 with SMTP id
 ffacd0b85a97d-4775c4be0e2mr12303138f8f.44.1783091336171; 
 Fri, 03 Jul 2026 08:08:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm18330f8f.2.2026.07.03.08.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:08:55 -0700 (PDT)
Date: Fri, 3 Jul 2026 11:08:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/2] hw/acpi: correct field sequence in SPCR table
Message-ID: <20260703110514-mutt-send-email-mst@kernel.org>
References: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
 <20260622111843.34056-2-heinrich.schuchardt@canonical.com>
 <CAKmqyKPeK-nCsemLAru6nkWP7V8qtA=XgW3ALuOJ5nFegF5F4Q@mail.gmail.com>
 <34ffc248-aa4d-4154-bf5d-3b095aff0144@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34ffc248-aa4d-4154-bf5d-3b095aff0144@canonical.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 29, 2026 at 08:12:12AM +0200, Heinrich Schuchardt wrote:
> On 6/29/26 02:58, Alistair Francis wrote:
> > On Mon, Jun 22, 2026 at 9:18 PM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > > 
> > > On LoongArch and RISC-V invalid SPCR tables are created:
> > > 
> > >      Terminal Type : 00
> > >      Language : 03
> > > 
> > > The correct values are:
> > > 
> > >      Terminal Type : 03
> > >      Language : 00
> > > 
> > > This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> > > SPCR creation to common location") that swapped the fields.
> > > 
> > > See the specification of the table in
> > > https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
> > > 
> > > This page shows version 1.10. But the sequence of the fields was not changed
> > > since version 1.0.
> > > 
> > > Our LoongArch and ARM code uses version 1.07 of the specification.
> > > Our RISC-V code uses version 1.10 of the specification.
> > > 
> > > Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
> > > Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
> > > Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > v4:
> > >          Reproduce the test data changes using rebuild-expected-aml.sh
> > >          creating the same diff as v3 but in two separate patches.
> > > v3:
> > >          Update test data
> > > v2:
> > >          Mention the different specification versions used by our code
> > >          https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
> > > v1:
> > >          https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
> > > ---
> > >   hw/acpi/aml-build.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 9b3cdd3781..990abc64cd 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
> > >       build_append_int_noprefix(table_data, f->stop_bits, 1);
> > >       /* Flow Control */
> > >       build_append_int_noprefix(table_data, f->flow_control, 1);
> > > -    /* Language */
> > > -    build_append_int_noprefix(table_data, f->language, 1);
> > >       /* Terminal Type */
> > >       build_append_int_noprefix(table_data, f->terminal_type, 1);
> > > +    /* Language */
> > > +    build_append_int_noprefix(table_data, f->language, 1);
> > 
> > Won't this break tests? Don't you need to disable the test first (then
> > re-enable it and fix it in patch 3)
> 
> Hello Alistair,
> 
> It would be helpful if /tests/qtest/bios-tables-test.c would clearly point
> out if changes to tests/qtest/bios-tables-test-allowed-diff.h and their
> reversion should be in the submitted patch series or not and what the
> acceptance criteria for the patch series are.
> 

1. add to allowed
2. code change
3. update expected
4. remove from allowed

1+2 and 3+4 can be combined


> I was not able to identify this from the existing text. So I eliminated
> those redundant changes.
> 
> Best regards
> 
> Heinrich

they are not redundant - they are to keep bisect working.
i don't know how to make it clearer.

> > 
> > Alistair
> > 
> > >       /* PCI Device ID  */
> > >       build_append_int_noprefix(table_data, f->pci_device_id, 2);
> > >       /* PCI Vendor ID */
> > > --
> > > 2.53.0
> > > 
> 
> 
> 


