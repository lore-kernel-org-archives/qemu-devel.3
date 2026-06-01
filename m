Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED560CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU9vq-00060A-K2; Mon, 01 Jun 2026 17:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU9vp-0005y4-HS
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU9vm-0001IC-Af
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780348336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YaCfkfQsNu+I0On9vpHT7wMmTBzLCYwM5MKtDylESro=;
 b=hD9jZ2V4fQI6ErQOIWkQOFllzN8kjge3xkocLBheRP1Y8LtqPPf7SGsQcENsTATe5ASzD9
 JjKaxr19SD0+R57MvplFihbCXdql27v7KApvjKARtv/KWb9QZ1vi8kYOsHTSjBEJmergUr
 AaveSXhQoqTs45hyOPuagoYbfpfT2JA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-WKoZSHL1OQK12K6oiHJ3VA-1; Mon, 01 Jun 2026 17:12:15 -0400
X-MC-Unique: WKoZSHL1OQK12K6oiHJ3VA-1
X-Mimecast-MFC-AGG-ID: WKoZSHL1OQK12K6oiHJ3VA_1780348334
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9156398570dso301467985a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780348334; x=1780953134; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YaCfkfQsNu+I0On9vpHT7wMmTBzLCYwM5MKtDylESro=;
 b=lvbPETxoUINvUQhopdsYnCZwdxqXkZcICfs+wg9uRzwEgsGNkUySow8OlSim3dY1Cc
 NT80lvch7nTZ5S7xCa6SfJqA7bhMkyxpqFCnL0Wgxlo1oIu8+V2v/UwrRjDAreGW2lnJ
 F0TDlHnaOPaO++JvC/9+lgkPJ/+6S8kEuZKzUEI/CIdd7++t6eoNzIw1mzx/zuY2N4pm
 /Nc6cOTNiPDzm8EiROJDOst0VNNHx6cWBTrRln4TCDNSG7dZjDtbIyJr1H4in2dfiVyM
 M5tm+mgXOe4QxYSH6CYxFL5cdmqWSzIFwPa0YE3sIQzqRGZ9zykDVq7NeP7Dpce3e1RO
 +i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348334; x=1780953134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaCfkfQsNu+I0On9vpHT7wMmTBzLCYwM5MKtDylESro=;
 b=I0QOszHCAx5fO/xhG11l3GvXRQSvRIzNs+crK0vUPDgGGTmctL2cjGgd1igVpPgGmk
 ABT3TPBakMFOJ99NtlQ1f64GiXzJgYNwMpanbSevGH5Ox1m3/eaGK3M3ewRlRPj2sZHU
 9QsEamtudkqOiaKzPvNe2d+ZW/jnWleZqtW21mQiyXYsqquvJDJD6oKb0OTzSVJEegA1
 q4lFdqQ68NKtwtOu/cnYDnATeHIqHKMxWqBRtFgeY2xqmgYoHxfg9mlGbZ0mEMRPPc8X
 hw6OyqSMMeSyflqEMzqk6mrhZqMv8bWsBZaSa5YzGMM6dK5Uz5xnOVJye5AvwjRcL46D
 zUtg==
X-Gm-Message-State: AOJu0YxWdMGVIvMg7r3iOXqCIjvNsJ7gK4zb0d6xZodyZ+3IyB0yhK5e
 +I8ptKJT5+NKWb+Q15GYQReGdBoN1eKqp9MwA7M21cO4jUDzuZ9/m1Fenjpp+9zDdarMDXegW1N
 oG5IjWel+KXrxRbr4JCoEqp/tWhBm+sjc0qMfc6Sqcw+a7cOPM82uiUX5
X-Gm-Gg: Acq92OGa3FWi5/Yvt7A+zHmj0yz7imswzq7mnw9MfjKUBMzwtF/0dxUX7xDg2yIOgEw
 npkMc7UXKvdFwOZm3tmALLhg4WldqkE7CdWAq0yVKlPQ63L8SlkTPQwBdmaldGeTWIly0ZLuIIi
 fqNOQVt66QkPrZ5kgN//CWxxnHbIoXOxFiw1dbsldiZtiewiYSmou0yEs+kinonnb+gK0Ynt41E
 tHNNxgHcUnBDmk8FlA304jMo1qsksoB9vX3ucxpGdpWUcitTw4QrxaCn44xCeUsp1URnd/ej12q
 8ofvQQvXnpjsnqt+ex1YEcL9+VWI9FGB7p81dl4EKiweAg9OQjsqRXlItC0sohHwCZKM2ViGdAO
 DxfAoSmerfRuQYqa2WCySrY5bVA==
X-Received: by 2002:a05:620a:4147:b0:915:7ad5:8982 with SMTP id
 af79cd13be357-9157ad594fcmr33969985a.50.1780348334277; 
 Mon, 01 Jun 2026 14:12:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4147:b0:915:7ad5:8982 with SMTP id
 af79cd13be357-9157ad594fcmr33963185a.50.1780348333815; 
 Mon, 01 Jun 2026 14:12:13 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91532294a7asm1105442285a.0.2026.06.01.14.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:12:13 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:12:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] qapi/migration: Remove @cpr-exec-command doc in
 MigrationParameter
Message-ID: <ah31q5qr_FkqVWzU@x1.local>
References: <20260528201236.359452-1-peterx@redhat.com>
 <87pl2ayg20.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pl2ayg20.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Jun 01, 2026 at 07:40:07AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This parameter was developed during similar window when the deduplication
> > work was done, hence overlooked.  MigrationParameter is already in
> > exception list of doc sanity checker.
> 
> Pointing to the exact commit(s) would be nice.  Not worth a respin,
> consider amending when you merge.

I queued this patch with commit message amended into below:

    qapi/migration: Remove @cpr-exec-command doc in MigrationParameter

    This parameter was developed during similar window when the deduplication
    work was done in commit 2220c2b9ef ("qapi/migration: Don't document
    MigrationParameter"), hence it was overlooked.
    
    Remove the leftover parameter.  After all, MigrationParameter is already in
    the exception list of the doc sanity checker.

[...]

>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!

-- 
Peter Xu


