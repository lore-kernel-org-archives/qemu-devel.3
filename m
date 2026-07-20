Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCFDC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrFw-0002eo-6w; Mon, 20 Jul 2026 12:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlrFJ-0002Bz-1K
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlrFD-0004ut-LA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784566410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCNxAoAyePYnj4zIbB6i/ezhGjEs5HjorO5UhBCu/uo=;
 b=fb8ZFcm/J9fr27pnrg9zb3ADmSfw47kOMO6UuXLV3hI8TovJ2yaG7htTw7kW3kkbNmWExN
 Xa19OI8JLWen8G0erLtgim/xJpy1624RCx6t0/vCgC7Ki+Ob7cGi3qWEUUmhYYgpv5QxJ/
 nR4FmGXSYoX18HGS7O5q5ZdlBPqpIQM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-PE6SVZJDPnW-WYk511jt0A-1; Mon, 20 Jul 2026 12:53:28 -0400
X-MC-Unique: PE6SVZJDPnW-WYk511jt0A-1
X-Mimecast-MFC-AGG-ID: PE6SVZJDPnW-WYk511jt0A_1784566407
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c1662ffbf57so753482766b.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784566407; x=1785171207; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VCNxAoAyePYnj4zIbB6i/ezhGjEs5HjorO5UhBCu/uo=;
 b=FhFOiZhU2aiKyCisH9nxf6A7Nx6Xy6hHoFNN52MvIc7XM+eg4NDkiT8zk4PT2NZGHc
 KrfpChYD+CbgrZX9u3ELPZnc/sS4BFqywt3INv0bQyO5yT9jsRw3sYfQuC5lETO4TtrT
 4nYuVvIV7Rvl01+RzgsXdQISNnWLY8bu/sZGl7C3mBhTYcZZu4VGQ0u0oDpNAZcChjr6
 n5paU4wgD2yixT7tmX9zeZ/ESH6M07NSzEIlZjIyIPLp7aFA944XtJ7/FQjtSV3POZrU
 cMRr0ovYt1Hw/fTfpYno4rU6dda7/Dc0FNWlHW0YSCOsMCvXJGRK0NxUcc/Ck/ZJ7+Cu
 Pl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784566407; x=1785171207;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VCNxAoAyePYnj4zIbB6i/ezhGjEs5HjorO5UhBCu/uo=;
 b=ZVpxM8HmpaTqtTxA3Dz3tdKKKfPRBWjjLN9R2V5J9m6xG68kbq8fb1TFBYzwoBNpfP
 rhZZcgtKXOACh+JiYIYAix2BgFix6+HOmXdW61kjTzQrHx9Li92hB1S155lZG035PfBQ
 YYU3zEwsz0jFB7dBpLKbU9fn1RbJu1OwrdqVo0Tfy/n8K7uK9229EhPgJqfPQ85Oq/QJ
 bpXR75RFZR4dDF3oly8Y0Mi+FgYSQmNo/zjNUeR59IS/7sCz6dN3MwDVHjcqzY1m5sZn
 WmTw63FYQrhY8SDV+RKYvq3BvBfeRnOOYvD83UMQvRoLL7IixsvKFJfPGHMc0CfSUuQ3
 9NXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqw9wwWDqz5s2zFEMm+4nX1/iTfVNd9jGXOFC2RPs5LkM8uFJkWTNj70yZUqfl8hby4o0OvKgUu5wUP@nongnu.org
X-Gm-Message-State: AOJu0YwbgqraXX0rn0iYbJkWIK9GWAzUAtYjrz/y/s6MSLauIWe/C7MK
 kXcEMt4sAuIncbAbsGm+4D+5ch+tr+/8SwTgrA4DxCiMBuRbU7Xl1px8nGRdlYEkZLQ9PKZloGA
 75wNCQlhSs9ukqdh4SEWVQyho/OQK3VopDzFI8iA63M+MAE60vtIw11iD
X-Gm-Gg: AfdE7cmXuPHsIHQT2WobdD4DC4XGDk4cLAuGcmRRkwxyNNAiTV4MtxoKBrh/v/suJTl
 k52YBCgFbmqJaRQX/72wJBzIKQnFKBFZ7JwDi+28kOTzeyr3pq6Wcnw49flp1vRADZzaFJD1q6R
 4wZPZb2SRIQqX0dpZD3k1dF7xJJjDzCyTThlcvAZrj2LbyuteP6D2rT01kLlhDW6Jea3nFyB6FQ
 y7nmHfOQH9Xjk3Q6ZQ9H8+qjVfZERgYFJaPv3aDAx6zGqrzEgfvCKm6L+nJEFy17/kXoy1r2O9b
 HBsK2qztA6vc3PGaQzPS+le+MbzVu87/QvLqby23/Lt6VqWxEqvVvQwtARFQohumBqdP
X-Received: by 2002:a17:907:9623:b0:c15:f65a:43a8 with SMTP id
 a640c23a62f3a-c16b4571a28mr641963866b.12.1784566406949; 
 Mon, 20 Jul 2026 09:53:26 -0700 (PDT)
X-Received: by 2002:a17:907:9623:b0:c15:f65a:43a8 with SMTP id
 a640c23a62f3a-c16b4571a28mr641961466b.12.1784566406442; 
 Mon, 20 Jul 2026 09:53:26 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1705912972sm492102766b.14.2026.07.20.09.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:53:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:53:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <al5Sd4dqho4baw8h@x1.local>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <al46bcG96ARl5Rf6@redhat.com> <87zezl3ag5.fsf@suse.de>
 <al5MVNaPRM6GUtLc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al5MVNaPRM6GUtLc@redhat.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 05:27:00PM +0100, Daniel P. Berrangé wrote:
> We should likely distinguish live migration from snapshots
> a little.
> 
> In live migration if loading aborts, we still have the source
> VM running fine.
> 
> With snapshots if you launch a new QEMU and restore from snapshot
> there was no source VM that's relevant.
> 
> With snapshots if you have a running QEMU and rollback to a
> snapshot (with loadvm), and QEMU crashes, you've lost your
> currently running QEMU.

Yes, it's a different case, but IMHO not different from triaging security
issues.

loadvm on top of live QEMU is almost saying, "quit this qemu, and start
that snapshot VM instead, without bothering re-starting another process,
because they have the same hardware layout".

So it's not the loadvm process that destroyed the "source QEMU", it's the
user decision.  That's the case with/without loadvm being successful.

Thanks,

-- 
Peter Xu


