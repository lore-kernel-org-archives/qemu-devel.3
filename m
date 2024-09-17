Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BBBC35FFD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUN0-0001Wn-Mv; Tue, 17 Sep 2024 05:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUMy-0001Vi-2g
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUMw-0004Dp-2o
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726564765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUX/cDE3gOpSZUKXDw0O/fMf4D971hqREO3NNvXeAJs=;
 b=UM3QPfZ65BpM5nFxffxtDdKHmKzwm7Q0fCUFyPzybVQR5leFNEPmSjH59KvTHI/vvydTlU
 ErkbL2+jmRNKz2ungLWbBgUQO7pAICnPz5Zs1m2BsCTU+38fBt74U71SeT2wpztFzKiWOc
 C0deO/rp1rKofSAFbwzHketmalMUGHU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-UrXaBJFbOZ2sie_MUJAJKQ-1; Tue, 17 Sep 2024 05:19:24 -0400
X-MC-Unique: UrXaBJFbOZ2sie_MUJAJKQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c35b8e38so1393331f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 02:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726564763; x=1727169563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUX/cDE3gOpSZUKXDw0O/fMf4D971hqREO3NNvXeAJs=;
 b=sj+FIFi2sG4Qu5Y3awxUk05ZaoPPRqgrE5AznvLj0nhYz7d11nFTd1II82vr6/0UYA
 zP0s/yDHOMmcQh7nMF9DCV94nx1kB6ByUR2Z0BGTEUtz7o78NUMmt5fUaJWHeAZk7u7f
 0jmKuHgayPcwts4JPKQ3u9YU+2WxvJhgzhRLxo0LLJALamCSZVd6WdwcwvSeTh1BXqq8
 E5Q7LGETwkQf9Oi1yXMqaPbX1JePc8mflrZ1RP2lkjSyyglkQP5ki75KGJsPgs9pemJw
 bJC9iDLvHNwsiVWvrKOu/f4+cCMEcWTjb4gayb7XWbhed1hDx7kFPE5p2xcp/iMxucRy
 6aNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYnm0Q15iI5Krot6M9Tp+1G0xfAFYQ2NfM7o9doXlq5tf3qwJ6SBLOhdaujklxmaof0U82W7goeKKy@nongnu.org
X-Gm-Message-State: AOJu0Yx2fWL7yahsrsk2KWw4/wKH7XKAqjC1nDNwEsqPi+qFq2Qw+H/u
 YHUGikNKF5viV0By+YxKjtULf8HgKqMNKqLvXRzpoOp6KyRAdbR6L1oTnLRv7yozzaG3oCa0DUj
 t7leSMctx2/BmRVrDAnL7M+B15IilPg1N0fObA46FGhEhl2g0HAdF
X-Received: by 2002:a05:6000:120d:b0:371:82ec:206f with SMTP id
 ffacd0b85a97d-378d61e2871mr7662718f8f.16.1726564763158; 
 Tue, 17 Sep 2024 02:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv0lTzGa0En47cTCylvcPoC7R3ZsfV7mcSql4HpZVVz0Cn5vdXmB2CE6F2pXgFsdS98qHtrQ==
X-Received: by 2002:a05:6000:120d:b0:371:82ec:206f with SMTP id
 ffacd0b85a97d-378d61e2871mr7662700f8f.16.1726564762614; 
 Tue, 17 Sep 2024 02:19:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7804483sm8908721f8f.92.2024.09.17.02.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 02:19:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:19:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20240917111921.7e95726b@imammedo.users.ipa.redhat.com>
In-Reply-To: <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 14 Sep 2024 08:13:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Increase migration version and change needed to check for both
> ghes_addr_le and hest_addr_le
But I don't think it will work like this (but I might be easily wrong)
However I don't know enough to properly review this patch, CCing Peter & Fabiano

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..4e5e387ee2df 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
>  
>  static const VMStateDescription vmstate_ghes = {
>      .name = "acpi-ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
>  static bool ghes_needed(void *opaque)
>  {
>      AcpiGedState *s = opaque;
> -    return s->ghes_state.ghes_addr_le;
> +    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
>  }

what I would do:
  add ghes_needed_v2(): return  s->ghes_state.hest_addr_le;

and then instead of reusing vmstate_ghes_state would add new
vmstate_ghes_v2_state subsection that migrates only 
  VMSTATE_UINT64(hest_addr_le, AcpiGhesState)
field.

btw: we probably don't need ghes_addr_le for new code that
uses HEST to lookup relevant error status block.
but we should still keep it for 9.1 and older machine types
as they expect/use it. Separate subsections would work with
this req just fine.

>  static const VMStateDescription vmstate_ghes_state = {
>      .name = "acpi-ged/ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .needed = ghes_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,


