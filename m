Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D62CAC58C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 15:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwMt3-0001Ne-LB; Wed, 10 Sep 2025 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwMt0-0001Ml-Mr
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwMsy-0000mZ-Ak
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757518645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kz9SnuI3/vpVZX5JTY6tsF5sQkS6K7Yu30w0y6EtaSE=;
 b=fvLL7s6p3B62R3t4/NUmbqIxGXHKTDb6LK6cDn6VpyTegJWzLJ2mTpqSrKoFaQUKU6PfwZ
 DHy0A8JkSEspNNoBp+T1HMbCoZQATp+D+LQzsOSjxuPyMNBR38pHrg/AUYtl8yEffV1jt1
 HBnAHJ4vNP1PAtkrNTxoh2xkTZq1PWg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-yQW9m915PtyW2570vwW38A-1; Wed, 10 Sep 2025 11:37:24 -0400
X-MC-Unique: yQW9m915PtyW2570vwW38A-1
X-Mimecast-MFC-AGG-ID: yQW9m915PtyW2570vwW38A_1757518644
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-810591dd04fso1448309785a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 08:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757518644; x=1758123444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz9SnuI3/vpVZX5JTY6tsF5sQkS6K7Yu30w0y6EtaSE=;
 b=dA2YFZSZ2HhBYn9EkpKGz4zXxqvurI+EAkgor6zZ+8eibbLtvNNYWr92xFWSKxodBf
 YPUtZaswWGlUeQVfGkoSESgRChxj2SrQIJhF5+cQ7VO4Wl44o2QkbG3dA9QPbhmJEcnr
 mpUwVgbn7wFYigfLX705oX+ckKryaROPn5OLAsl4p4Ug/UhQLhZ05SWBJhLOsNiHij3O
 BWLYmUepU3wqoAr9P9Os1rcfIi0q4fd0jMkcnXbAac67tKNb8+z92U3vcDZjlxgKRs/Z
 sYudnrk3vooEqnphzaQzQAXeiT0hE7mlUqA4ztiH6KyagID0QV+3R1ueSLexotgF2fDV
 MM4Q==
X-Gm-Message-State: AOJu0YzVr9kAKsKwcYv1MdtfzmzG7RO6ECChKfQkwkM9sIAOAnpGAtXO
 tDGLgIPtbL8uEVWlzf1eoH9CLDgfEAZTXfVAn2Pz/f7iUx/ECz22XYK/8CsDieeuYIPopNdZg02
 BxP8tuaGRozpcoGEr4FdJHJlaZ846j1Sl9Cdw+yI4c6Wl7JcVIQGo2lcJ
X-Gm-Gg: ASbGnctf8gZVid8v8NsefGB+JcWhBHgHpPG9AkYKa9iaWi207MeaLFURtBonnsXl96r
 fizE6nXo0vmz4Y9Rm1WdQ7ouExwq2Q+F5Cf7BDXZlcBtGGugTw28C5LQNhaR1WAGBk4pFrJmz1E
 kmGtOMZvhHsvxOMfezyoSu/3nLqkShOpld8klOQEtNWryBxHEe4vSrhHQmb3MT1rrlRaV/LfTNh
 YkJdjSxDCjYL8K+sn592502T8rv5Jkbr9XnU18tbothKXqyO3jqtGlX3hblwgr9pALnpYsK+v6R
 XbMZ8c6+bJWvJZ/k94vZPOeEi9AaKYZg
X-Received: by 2002:a05:620a:2795:b0:813:f407:b231 with SMTP id
 af79cd13be357-813f407b2c1mr1353189585a.7.1757518643594; 
 Wed, 10 Sep 2025 08:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf/KuVdeKLvj4EGYJry2HAEzT1NBiK0ZFDkaqiHiRRXlDFFH/PmMK8tC1foIGn96Mz68XKwA==
X-Received: by 2002:a05:620a:2795:b0:813:f407:b231 with SMTP id
 af79cd13be357-813f407b2c1mr1353183785a.7.1757518642801; 
 Wed, 10 Sep 2025 08:37:22 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbbc0ecsm25838081cf.25.2025.09.10.08.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 08:37:22 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:37:10 -0400
From: Peter Xu <peterx@redhat.com>
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/4] include/migration: Add support for a
 variable-length array of UINT32 pointers
Message-ID: <aMGbJusVNgQ-N7y3@x1.local>
References: <20250910-timers-v2-0-31359f1f6ee8@linux.alibaba.com>
 <20250910-timers-v2-2-31359f1f6ee8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910-timers-v2-2-31359f1f6ee8@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 10, 2025 at 11:04:26PM +0800, TANG Tiancheng wrote:
> Add support for defining a vmstate field which is a variable-length array
> of pointers, and use this to define a VMSTATE_TIMER_PTR_VARRAY() which allows
> a variable-length array of QEMUTimer* to be used by devices.
> 
> Message-id: 20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>

Thanks.

No need for a repost, but the subject can be prefixed directly with
"migration", if can be fixed when merge.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


