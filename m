Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3EDCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfLw-0006GD-MP; Mon, 22 Jun 2026 10:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbfLj-00067c-At
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbfLh-0004BC-N0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782137404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RoslsTU89MryP+ngDAbFzBwDJfOMZuofSQ5w54HgKkw=;
 b=N9+yUloASpWuVqwmknBzR5FmC5bTL29emO8S72YFY0CjnMRSY8Ifi5m2+LimfVMvuKhNi4
 FHF6zcQaASc67zbc3WjAG0OEAK60nvsA/tu8ymlTP8allsRUpS+WZNhM4MEKVIhPt3Pk4I
 FKVzwn+geFpXJnGgmLi3fmz4bepTXXE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xU__-Qm7P9WJLtTPQ1UxCA-1; Mon, 22 Jun 2026 10:10:02 -0400
X-MC-Unique: xU__-Qm7P9WJLtTPQ1UxCA-1
X-Mimecast-MFC-AGG-ID: xU__-Qm7P9WJLtTPQ1UxCA_1782137401
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4924314568cso26996195e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782137401; x=1782742201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoslsTU89MryP+ngDAbFzBwDJfOMZuofSQ5w54HgKkw=;
 b=OFVwnQ07O8UoJYeK7BBkxdvARbs0YmhC+tHoRd9Ul2sZ4QCCH98NMR6l7sHEnEQSpU
 7m8bMNj38WSTa4OkAVqBjHseETRuCJkrK5h0D0Zdsy520nzuZ8KrKgeyBtH0j7Ywk4FS
 PySQIi0UAEvth+C9dV/kxsZsFfyxnUvcH9YIPIiOe7oPY7R7aCRpXDjRkE4ZeiUQHbID
 eok7+FBrpGtDRDuEqNJmiAqW6bAUZXvTDpDME/YPnJl/0JL+W4cBDwRL+cpC52qGzVMm
 4lDQL77CSIsfIS/OhOaMl0Ct9Bh0IdrWKEHBbm7XaUKG6WmTtjOHFC+tt6tew/Shuc9G
 jbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782137401; x=1782742201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RoslsTU89MryP+ngDAbFzBwDJfOMZuofSQ5w54HgKkw=;
 b=FDxCeJKrPujpo6ootVarOlKIyKyCl/47a9cTy6s7SDo9+sfbLdQMiola092LSmdU63
 9HD345ZQF/1LVHQwV6AFYuE6nIgAhuXwXn/YsEfhuTD+aM+hrXLSYsL0fWOpHzjoCRlr
 VQPRXJ+6nExi+5n7WofsbKDbrHp2u4+tSWBreiPM0qT/vajTrz2yLDTx/DIybec83JK3
 MMYw24dTBnsALceP2qe0IGw67SbviCgjZa2DikmCBdQa01EmflOkeXtdIR4/324AzpoN
 WO7irOdtH4gB9qdCMOAdpbajEFzIxIuEI0gWIwe8YGk7lV+NGbd/9qjlzFOYplVDtBTf
 Wa2w==
X-Gm-Message-State: AOJu0YzwpISJBGiPSYfTDGvVLLo4IRffuQDTBot11xSdcyrG1tLFLOWs
 ob6P0P+75aP/BwAq2cCDwJuERMm6/FMdPiDtc9ySySSHm0hRoGTU7SRKgUe2MXbnrjcPAs6oe6H
 jDZyhR4Ty6HnP8RP0FYJq7gtxo50AlwCXwvHXy+l9vmr/P0hk3aeFpGGRQUhubFte
X-Gm-Gg: AfdE7cn9lK8MEhiWTU/675dywuQHaH8lwYSssfXszMFWWhAMDnpUVcmFWI1G0v9Tv/0
 C9CWxbqKEqx0ZwFJWtjGX5696qoMdfH64XXZfqrNxOoY7ww3wi4NVNZSSYC+mRopSd7fE7V584y
 MEJO+gDbVp0ex6k9mgnQMQniqfNn+DJ5eyjWaiJd5XBH8BjoyCPUxnGG1QDVvoCZ+wQ7PM1YdfS
 brrd/V2Tft7xzWzUW0rZdoMhVXKOr9O+5SGO1UauNa1bSe+OM/ctjw+ljSQRPSAsL7KKuRCvxwB
 TzO5AW+u2g8UtxQrN1msisBOIRH0zB+L6+nWWKy9c9nBhSwrch7sc/di8V1T9hSLqnpqjGM=
X-Received: by 2002:a05:600c:3b26:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-4923ef5b897mr300461085e9.10.1782137401136; 
 Mon, 22 Jun 2026 07:10:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3b26:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-4923ef5b897mr300460225e9.10.1782137400542; 
 Mon, 22 Jun 2026 07:10:00 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff821aasm318362395e9.12.2026.06.22.07.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:10:00 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:09:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 10/10] tests/qtest: cover sp-mem SOFT_RESERVED e820
 entry
Message-ID: <20260622160959.428c358a@imammedo>
In-Reply-To: <20260619111136.3481329-11-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-11-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 19 Jun 2026 19:11:36 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Boot one sp-mem device and assert the guest's e820 table gains exactly
> one E820_SOFT_RESERVED range whose length matches the device's backend
> size.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/e820-test.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tests/qtest/e820-test.c b/tests/qtest/e820-test.c
> index 1db0744c08..aafa3c1aa2 100644
> --- a/tests/qtest/e820-test.c
> +++ b/tests/qtest/e820-test.c
> @@ -16,6 +16,7 @@
>  #include "libqtest.h"
>  #include "libqos/fw_cfg.h"
>  #include "qemu/bswap.h"
> +#include "qemu/units.h"
>  
>  /* e820 entry layout and types (cf. hw/i386/e820_memory_layout.h) */
>  #define E820_RAM            1
> @@ -85,11 +86,44 @@ static void test_e820_basic(void)
>      qtest_quit(s);
>  }
>  
> +static void test_e820_sp_mem(void)
> +{
> +    struct e820_entry table[E820_MAX_ENTRIES];
> +    QFWCFG *fw_cfg;
> +    QTestState *s;
> +    size_t n, i;
> +    int soft_reserved = 0;
> +    uint64_t soft_reserved_len = 0;
> +
> +    s = qtest_init("-machine q35 -m 256M,slots=2,maxmem=2G "
> +                   "-object memory-backend-ram,id=ram0,size=256M "
> +                   "-numa node,nodeid=0,memdev=ram0 "
> +                   "-object memory-backend-ram,id=spm0,size=128M "
> +                   "-device sp-mem,id=sp0,memdev=spm0,node=0");
> +    fw_cfg = pc_fw_cfg_init(s);
> +
> +    n = get_e820_table(fw_cfg, table);
> +    for (i = 0; i < n; i++) {
> +        if (le32_to_cpu(table[i].type) == E820_SOFT_RESERVED) {
> +            soft_reserved++;
> +            soft_reserved_len = le64_to_cpu(table[i].length);
> +        }
> +    }
> +
> +    /* exactly one SOFT_RESERVED range, sized to the backend */
> +    g_assert_cmpint(soft_reserved, ==, 1);
> +    g_assert_cmpint(soft_reserved_len, ==, 128 * MiB);
> +
> +    pc_fw_cfg_uninit(fw_cfg);
> +    qtest_quit(s);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>  
>      qtest_add_func("e820/basic", test_e820_basic);
> +    qtest_add_func("e820/sp-mem", test_e820_sp_mem);
>  
>      return g_test_run();
>  }


