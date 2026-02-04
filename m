Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEC1EA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 21:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjyR-0004ik-PS; Wed, 04 Feb 2026 15:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnjyQ-0004iS-26
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnjyO-0005dC-5x
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770238778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i0cw9t1aWTKQ1/nKKYDKQelKwsT2XNqw2beHE8+3rFQ=;
 b=KmWswqqBRNhi7CDUheqz0yYjbUHgNK3JCOXrIB+7IQsRtUBxVv6L5urbGc/J/y+GjQqkyI
 hd1XP1ESr/cYUPQUSulcZd4mkb2xsnGZj4rf8e0tmNUAUhMc6Mv63NQTNwe9qTARd5LIkI
 abI09ikvocJH+s3s8G6xSsTcJk7OD2Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-GNy0hmi2Pr-6lICWLZTECQ-1; Wed, 04 Feb 2026 15:59:36 -0500
X-MC-Unique: GNy0hmi2Pr-6lICWLZTECQ-1
X-Mimecast-MFC-AGG-ID: GNy0hmi2Pr-6lICWLZTECQ_1770238776
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89473f5a755so8394136d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770238776; x=1770843576; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i0cw9t1aWTKQ1/nKKYDKQelKwsT2XNqw2beHE8+3rFQ=;
 b=dGtVuQ+J5Dl6R4vAc/6QvKBn+6L42hSfonCPcR+N6IwgHs7stkz1Z/gL4f7M7GJRlz
 d09U0sH/m3vHrV+rxrkhHMRksPMOzz6RWvyzR9yAzTzDwIpulAtMn4Nonm+bnccnY4JI
 h5GxVy5xrolH5GyNyT/ogUQ0cOYcnkb2/YpPsfJb0SVv90T72RuBhFf4ksD4wHq+MHUs
 kxvl5JPzV3PGhlcBdjOpeaskceIqX4fLIRqSsstOL0KeKnF6KujS9RWgnZ2rRNhmc3/B
 3j5cPivX+RvkexWOSEF4KIrMEXAojKco2qELPXhcIBkiV8GwXEqJ4mcRqQG0ObkoXlks
 uEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770238776; x=1770843576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0cw9t1aWTKQ1/nKKYDKQelKwsT2XNqw2beHE8+3rFQ=;
 b=gbIT4OJAp3sZBrN3HBgrs/xaw8r4UlD+bN31NB3dKobNYRdjs+ldztPC7Bq82JQQcZ
 kDIdtbEDOxWAr4xEDOjMMQNGrQIMkGdkZX/Ip+lLazXOfeqEwJKzt9ObVS0/7WixOPN0
 LsXESL8GniRneC/Zh0XyIPzRURXh60BBnEuRQ8AX3CBQsuf7dv4sqwFuBdbfw8J6Mtyv
 KDt712gQjT51Iv1spRuDqc1a5+WV2vDIkRv/Yw0biED6tiVyDXsJW83/C9mrUz77feit
 rAxj5voOCypBNxNA+DS1H+TNedXKs0sFCm4eIHcXHm3lhA2ShK7aSpDuseHeLkLZtDt7
 97Pg==
X-Gm-Message-State: AOJu0YwDp5sUxhJyHrnaQDp0bqnEb3OFmOrF0IcFzpZ+n/5Rde4h8/7r
 OAC16qYBTCRUINDDHop6wMbXZ9eTz3uvzYVnLR7b2CVGFhcDcw64X5APbAoCLlVgkMG3HJHomQI
 TQCto/LvztNkEedIm4A/7Nrp30jYUWplngJc4yUBgVSD/K2LOZtEQVzRn
X-Gm-Gg: AZuq6aJE35wXmcPzzRiW5xlMbbXvzuzwIFRMO2t9mruPTN4K0AVhfXTe+NNH1lICjnW
 x6mAQ+W4vRdtC98nYbBB/ZqRcnIA+6DrFjrOEoa0gSzfbhsDkqiJZQpc0K9eIH6vjeC/COHqNIo
 t/y0VvY1DGJXZ9nWOER27lnu+/ZskF7O9x7+E55vmvnQDxuwOL2QTiL52PsX1MttsCy5RGEQaCh
 pgF98pRH4zcnndrk/u8XBIfA8APfvk75VJv+Jtr5dcx/KwFW3++doTOxjKBcQk5UWHPdngzbNz1
 xgCIPR1Bfivrxv9cZOesUQgFSGuC69ZR+UTTKWyhjBqyNZzTYtPFCdHYzcB34u9kx+qaIhfSDH1
 MLiU=
X-Received: by 2002:a05:6214:c2d:b0:880:854:908f with SMTP id
 6a1803df08f44-895221a77ecmr67515336d6.38.1770238775997; 
 Wed, 04 Feb 2026 12:59:35 -0800 (PST)
X-Received: by 2002:a05:6214:c2d:b0:880:854:908f with SMTP id
 6a1803df08f44-895221a77ecmr67515006d6.38.1770238775571; 
 Wed, 04 Feb 2026 12:59:35 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521bfe7f6sm27324936d6.5.2026.02.04.12.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 12:59:34 -0800 (PST)
Date: Wed, 4 Feb 2026 15:59:33 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 6/7] memory: Factor out common ram region initialization
Message-ID: <aYOzNeoBw0Hu3zk2@x1.local>
References: <cover.1770042013.git.balaton@eik.bme.hu>
 <e938355d877a0f8645ca51f863517f8a73febe2c.1770042013.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e938355d877a0f8645ca51f863517f8a73febe2c.1770042013.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 02, 2026 at 03:28:17PM +0100, BALATON Zoltan wrote:
> -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
> -                                            Object *owner,
> -                                            const char *name,
> -                                            uint64_t size,
> -                                            uint32_t ram_flags,
> -                                            Error **errp)
> +static bool memory_region_do_init_ram(MemoryRegion *mr,
> +                                      Error *err, Error **errp)

I keep thinking taking two Errors here is almost not readable for an init
function.  It only makes sense to me if it's something like
error_propagate().  E.g. we also have migrate_error_propagate().  I can't
think of anything that should pass in two Errors..

I'm not sure how bad it is we keep the old code as-is.. but if we really
want to provide some helpers, IMHO we should still avoid this, maybe:

memory_region_ram_setup(mr)
{
  mr->ram = true;
  mr->terminates = true;
  mr->destructor = memory_region_destructor_ram;
}

memory_region_error_propagate(mr, err, errp)
{
  mr->size = int128_zero();
  object_unparent(OBJECT(mr));
  error_propagate(errp, err);
}

Then taking one example:

memory_region_init_ram_flags_nomigrate()
{
  Error *err = NULL;
  memory_region_init(mr, owner, name, size);
  memory_region_ram_setup(mr);
  mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
  if (err) {
    memory_region_error_propagate(mr, err, errp);
    return false;
  }
  return true;
}

Thanks,

-- 
Peter Xu


