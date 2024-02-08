Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B1CC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 14:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY5IT-0001Oz-9x; Thu, 08 Feb 2024 09:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rY5ID-0001MU-9h
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rY5IA-0005sj-En
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707402137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAla9J4PVDqycTuoekfcB6U5If2dSmAvYvLz7BgmNoQ=;
 b=Gxv/+1+bJNeC96+zDt2eugAhsZBXqvfjK9qCWezifNIbWopl7dOTojWM9WGrP4lwfTUDeJ
 vXaOTrLzmfi1XgEwPibEcyBOVb7RP1/R5bW0aqWfs+XqL91BXWazg9hcD82YYcT9dK8jjR
 yWKji6iomgvUjdka/33880OHT+jtTEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-dlziQXbcOvCOicqYfWWaBw-1; Thu, 08 Feb 2024 09:22:14 -0500
X-MC-Unique: dlziQXbcOvCOicqYfWWaBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1069185A780;
 Thu,  8 Feb 2024 14:22:13 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CEAA1C14B0B;
 Thu,  8 Feb 2024 14:22:13 +0000 (UTC)
Date: Thu, 8 Feb 2024 15:22:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH] iothread: Simplify expression in qemu_in_iothread()
Message-ID: <ZcTjlNeibKUnIDcL@redhat.com>
References: <20240208101657.15962-1-kwolf@redhat.com>
 <ffe07fee-0cda-4517-a64b-031cb922d806@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffe07fee-0cda-4517-a64b-031cb922d806@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 08.02.2024 um 11:48 hat Philippe Mathieu-Daudé geschrieben:
> On 8/2/24 11:16, Kevin Wolf wrote:
> > 'a == b ? false : true' is a rather convoluted way of writing 'a != b'.
> > Use the more obvious way to write it.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   iothread.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/iothread.c b/iothread.c
> > index 6c1fc8c856..e1e9e04736 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -404,6 +404,5 @@ IOThread *iothread_by_id(const char *id)
> >   bool qemu_in_iothread(void)
> >   {
> > -    return qemu_get_current_aio_context() == qemu_get_aio_context() ?
> > -                    false : true;
> > +    return qemu_get_current_aio_context() != qemu_get_aio_context();
> >   }
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> BTW using the same pattern:
> 
> -- >8 --
> diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
> index ec98456e5d..d074762a25 100644
> --- a/hw/nvram/xlnx-zynqmp-efuse.c
> +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> @@ -582,7 +582,7 @@ static uint64_t
> zynqmp_efuse_cache_load_prew(RegisterInfo *reg,
> 
>  static uint64_t zynqmp_efuse_wr_lock_prew(RegisterInfo *reg, uint64_t val)
>  {
> -    return val == 0xDF0D ? 0 : 1;
> +    return val != 0xDF0D;
>  }

Maybe. I would have to know that device to tell if this is really meant
as boolean. Or maybe it should be written 0x0 and 0x1 to signify that
it's a register value or something.

> diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
> index 301e61d0dd..bdd73bd181 100644
> --- a/tests/tcg/aarch64/sysregs.c
> +++ b/tests/tcg/aarch64/sysregs.c
> @@ -183,5 +183,5 @@ int main(void)
>          return 1;
>      }
> 
> -    return should_fail_count == 6 ? 0 : 1;
> +    return should_fail_count != 6;
>  }

This one isn't unclear to me, though. This is EXIT_SUCCESS and
EXIT_FAILURE, just open-coded. I think making your change would make it
only more confusing.

Kevin


