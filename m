Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01AACDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbePU-00010S-4m; Mon, 22 Jun 2026 09:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbePN-0000zr-Qh
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbePL-0004yy-Du
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782133786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LoX6kfNbmpW44LFckkAov2gH5dtkmEu3DVu0apItLY=;
 b=X0x1E3G9jLvaW4Thq3/NvyjWnq6J/YN9yEqNHg2k3toXnMIWK6qBxA+qMEo2GJ25L6JUZP
 JvI0y1MDSlmjouPB2AJu0nCRpr/7CU9XBgmRFHe2vOlTjXgidlB7JzezZyFoX6JexfE2Fi
 xUb6/Q3ZAADc3dZbfLpGRtcz1hsskcU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-EFXGHvdHP0uG0AYhFScdsA-1; Mon, 22 Jun 2026 09:09:45 -0400
X-MC-Unique: EFXGHvdHP0uG0AYhFScdsA-1
X-Mimecast-MFC-AGG-ID: EFXGHvdHP0uG0AYhFScdsA_1782133784
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4639f122c38so3135300f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782133784; x=1782738584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LoX6kfNbmpW44LFckkAov2gH5dtkmEu3DVu0apItLY=;
 b=benBobL2Q7QIGYoJPgRopMvQ/IEoAFK5S6b+9BlN4385j0mCih8RLQ5gq9UtZ/wxSs
 OPhYp/W5FfgTx8fYMveFV8MzQl5Z8mvyUmmpFmk+wzzjo17pCGMvnp3PhS9IqRnk9kvz
 8x+IDPSa9xDiCUE0A6Oi4MqrzzCGw1Wu5+jus825sWzhqwX0neYT8N4VOiIBRVGds33z
 lYHpUO6bjVFMYaIQoM2+h7IG6ZP2YbkEM3xRaIX8y50mDplpGsrIFkK7BFcQvq4v4yD5
 sdW1X71r7uomVgDJsGbl0/VX5GQohNo+ahOejTp9begD52LACOlOk+AItIiifCo45e2v
 5XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782133784; x=1782738584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LoX6kfNbmpW44LFckkAov2gH5dtkmEu3DVu0apItLY=;
 b=ZGxGUsgIGsL+8JbnbQ1SIQVlAGV4ny7Lhg0fOafjrD6ZoAcUsYvNhE4PShzOaXSBEs
 HkdC+HSIHeXcll/XmeJWACmvvZkcyZHGihRtNSRTTL50pn8GFQ60e0WpMU865sIBlibn
 jNqyy4OG7FOZnxAoTqrwlUr22gfllWP77xpnBP8dP88dOTfo4ieyKfnHd6g8FKo3bo5F
 pseaJq87oNVKIsYagqa1ItKj5gPC09fHayYYIcZpPMVNR6CzxLzv8YTnChp0pshmv9Xy
 /i59RXi7z0K8oqxf8vUFd6z9gHPIILTgsg9ElLtHP9uUUkQPZs9DWZMVcc9vM6EVX44o
 S4tg==
X-Gm-Message-State: AOJu0YwTcX6gnWr9KPAk1wZBsVecVRrT0efoop1JK/0UPhwu3vfRRJA7
 xSYHsNW9PFRFk6LplVhNDqdGzpW7TgTA+byLUIqIPHCJsu+gFtBfAH0qmmru28B/xM2MsXEYZf3
 Gnj7GdeYu1oFR/vXLed/4djgb+T+f8NiavL0r85D+KhnhcuC3HarNBfK8
X-Gm-Gg: AfdE7ckbYxbGbz5iBsUwpzXrR5Btza0m/XQX2s1803+MQzMkI7Y+wpM2K/XC6c37OGb
 geCXgZgMp1Ser6v1VpDZa/LtCl03T24YJ8pqXt2ASOgRRheutHDdVBUy3MzPxgWdvRPNerY6WlU
 /qxl3MxwfM4lop5Jplo/Gj72LDqqb1QI14zhL9lRXUc55OuI2S50BdPXTFaLR582J4XleQIe3MU
 LSmRumXED2fGPG2ZI3aWVlUOb+ZLd8srnEp8ZPbwKOfdkFR8TKL2MnbLByr9xM+gOvRcXsz3T31
 aWSnyiIsslCSypTMsoeHBq9RZHV0L9wMqBRDZdUSLuubz2GpX8nhMhoczDGUq8EtmY6bfkc=
X-Received: by 2002:a05:600c:630d:b0:492:46c3:c7dc with SMTP id
 5b1f17b1804b1-4924908f450mr153755205e9.14.1782133783741; 
 Mon, 22 Jun 2026 06:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:492:46c3:c7dc with SMTP id
 5b1f17b1804b1-4924908f450mr153754455e9.14.1782133783054; 
 Mon, 22 Jun 2026 06:09:43 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a9e3sm320865015e9.14.2026.06.22.06.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:09:42 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:09:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 08/10] tests/acpi: generate expected blobs for
 sp-mem SRAT test
Message-ID: <20260622150941.3ad00643@imammedo>
In-Reply-To: <20260619111136.3481329-9-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-9-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 19 Jun 2026 19:11:34 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Populate the expected ACPI blobs for the sp-mem test and clear the
> allowed-diff list.
> 
> SRAT memory-affinity entries for the device_memory window (q35,
> -m 128M,maxmem=1G, sp0 on node 1 and sp1 on node 2, each 128M):
> 
>   Proximity Domain : 1  Base : 0x100000000  Length : 0x08000000  (Enabled)
>   Proximity Domain : 2  Base : 0x108000000  Length : 0x08000000  (Enabled)
>   Proximity Domain : 2  Base : 0x110000000  Length : 0x128000000 (Hot Pluggable)
> 
> Each sp-mem device gets an ENABLED entry at its own proximity domain;
> the remaining device_memory window is covered by a HOTPLUGGABLE
> placeholder at the highest proximity domain.
> 
> (DSDT.spmem differs from the base only by the memory-hotplug AML
> enabled by -m,maxmem.)
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   2 --
>  tests/data/acpi/x86/q35/DSDT.spmem          | Bin 0 -> 9910 bytes
>  tests/data/acpi/x86/q35/SRAT.spmem          | Bin 0 -> 384 bytes
>  3 files changed, 2 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 188003fa90..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,3 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/x86/q35/DSDT.spmem",
> -"tests/data/acpi/x86/q35/SRAT.spmem",
> diff --git a/tests/data/acpi/x86/q35/DSDT.spmem b/tests/data/acpi/x86/q35/DSDT.spmem
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7e6f850e7a25aaa3cb7abc0ff2aeab4ca7fdb716 100644
> GIT binary patch
> literal 9910
> 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
> MvBJ}12_H=T4{{!rhyVZp
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/x86/q35/SRAT.spmem b/tests/data/acpi/x86/q35/SRAT.spmem
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..9ecd266eda68d035f72f170cb1346b97da623c28 100644
> GIT binary patch
> literal 384
> zcmWFzatvu;WME+AbMklg2v%^42yj*a0-z8Bhz+7a7!Cwb`HUKH87PAbE`Y2Lp$=#O
> z7<^!dDa5W0CX1a$n1@{+CQ7_Ige#yd4!9XG29RddV1n^Dh*T#4Ri^>7ff;53kOlxB
> Ct_cAE
> 
> literal 0
> HcmV?d00001
> 


