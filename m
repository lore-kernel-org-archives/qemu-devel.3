Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4ADCD4F24
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 00:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLFU-0004gp-SX; Wed, 12 Nov 2025 19:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJLFP-0004bn-Dp
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJLFM-0003wF-Os
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762993888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmtCzZjz6lvxc3GSB6pmIroQ+/COvgnOoRQkvZSrt+o=;
 b=CL0hZnnJQLuzscoEHSOQUTmw+emH8Zpd5fqjCOQ51GLzYDVrqIeVFIYEo7qvQ/CaYkQsYr
 H6f3YY0ta3Km7ojFg9i9Inww/WQYj2DMwb2FycPDDA91oP8ak0KTmzeHoLKgeay1cg0Zuv
 oYvuwjj/VDUiemW615UvSupJC97m5Z0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-aYC4fbnxPS6ALC6KppsVDw-1; Wed, 12 Nov 2025 19:31:26 -0500
X-MC-Unique: aYC4fbnxPS6ALC6KppsVDw-1
X-Mimecast-MFC-AGG-ID: aYC4fbnxPS6ALC6KppsVDw_1762993886
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b57cf8dba28so252065a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 16:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762993886; x=1763598686; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmtCzZjz6lvxc3GSB6pmIroQ+/COvgnOoRQkvZSrt+o=;
 b=g56U9YnAb/+hMmf8vothD8Gshrtf9inrWMHyeY7gJGY6FowOrOo4brTIxemZPfumMg
 HlRndwlcZJyHsBkFqmpK58F6NqOnODXUcm9GGdg2BmTQqgVU38atpdLS7t65SsAWlkvb
 Zh0Wc7cZuPRmW0whCEO5bE5HPo8oH6XkkZ0Ofz2BXNfkJJCAZ1WRPuL/+Rno7Dtk/FRO
 QR/z6JBTgWei05wZIZmBWMla7e9r2UxWrk84bBWCjx/kiesF/qGpecGySbk2rVn2I+gr
 +GjJi+pyiG0gLBjC721bFY/FdkwVBI/+v+ESNPGhqHpVgS6QP+L57RWUYofW/chRjGX1
 Tqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762993886; x=1763598686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wmtCzZjz6lvxc3GSB6pmIroQ+/COvgnOoRQkvZSrt+o=;
 b=F9JwMKSrprB3YGB82l7+vlPECUs1usw60NnB5SpiKz3vZ9oUMq3k51SGzItSAM/u72
 FzGS061Q4qETkaYx6PdSWHq5NovXQscUnJUDT9/dG5FOyAYU2m9ZOTGpNUY0QOiNk5Ct
 U9q6TgDZF8HWAXBUN8QFK0fBWtA+eagj9A+fIUcm98L/XbhJxXYZE2XRvCqIIISRYBUp
 TWKnx1tUxXbUE6OHxMj5lIX6yVQalEj+ZrRfDv/KVddCoId6TTkP9+UpehYp2QH67zyr
 Mtna0cqbw1mojTfs9zivajcsl2Ba/y1mqcNa1WZ7EkTrN0F3uLNQjd/GnmkpinKTqpMh
 z7ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPTrnvV9D9rqEb3SLai7/zNnn8FZxr4SO2hEg6H6ptOqDmyOyOsrZB8FLQKiF3F/zvKi/ptkUsHLCH@nongnu.org
X-Gm-Message-State: AOJu0Yxx166G7RZ+h9f6hGNwpPtZ195BhndLwVS8FLcjUw5uHVgjOES4
 951kDye3i7GagWr8U3sBddqvwGmiYO3reaCgdm94Vz4i5FD9b6ZGcyhoxLpKb10/eWwQSjSSA5X
 jrkY2kWds4R3Qf6BbP8hybEfl+QhtsjalnYe0JXDCQ9f79cjF/l4y8cxL/EEPDF4fweVozlaDMq
 C6kA3pQf5kmiAVLXhwTFjM/CN1wv7ny3Q=
X-Gm-Gg: ASbGncuZo3nOfR1uigCuQq031jGqYHF2sALMZ4t07bnFyd9fhmUy46eicSmmql41t0S
 Ltl7Qm1iDD7wbNj7LLjb0Us3rilFTypCOCi/lvVBF25uYZIk95Fi+LfpVLqEfna8IkL7vFakMEa
 itCoyH8lF60JuzvsoTskSHzxNcb2fWFun4kAn2eNZKd72cQdC9U0zjAw==
X-Received: by 2002:a17:90b:3e4c:b0:340:c179:365a with SMTP id
 98e67ed59e1d1-343ddcc9f2bmr6567809a91.0.1762993885833; 
 Wed, 12 Nov 2025 16:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfuoSY9u245LJuhpFMwlUw+ypAV7mbtWJ6mNAybOhC8jbFrZgqlHyO7p6R6WVU8IO+v4S9Oe1cZDCigGJEYQ8=
X-Received: by 2002:a17:90b:3e4c:b0:340:c179:365a with SMTP id
 98e67ed59e1d1-343ddcc9f2bmr6567767a91.0.1762993885306; Wed, 12 Nov 2025
 16:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20251107020149.3223-1-jasowang@redhat.com>
 <aRUCXvHkpfZgZCR0@x1.local>
In-Reply-To: <aRUCXvHkpfZgZCR0@x1.local>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Nov 2025 08:31:14 +0800
X-Gm-Features: AWmQ_bluPkuKpHiRreyMlDu6EsOfcZIhRFlH02GlH6huZIZYnhfbRz13wJkirH0
Message-ID: <CACGkMEui+A8HFpxKpaSjLTqJHPSaq0Pko18af-APYguznK6bOg@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
To: Peter Xu <peterx@redhat.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com, 
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com, 
 thuth@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 13, 2025 at 5:55=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > We used to clear features silently in virtio_net_get_features() even
> > if it is required. This complicates the live migration compatibility
> > as the management layer may think the feature is enabled but in fact
> > not.
> >
> > Let's add a strict feature check to make sure if there's a mismatch
> > between the required feature and peer, fail the get_features()
> > immediately instead of waiting until the migration to fail. This
> > offload the migration compatibility completely to the management
> > layer.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Jason, thanks for help looking into the problem!
>
> Am I right that after this patch applied, whenever a new QEMU boots with
> the new machine types (e.g. having USO* by default ON), will fail to boot
> on an old kernel that doesn't support USO*, but ask the users to turn off
> USO* features explicitly in the virtio-net devices?
>
> Thanks,

Yes, I wonder if this can help in dealing with migration compatibility issu=
es.

Thanks


