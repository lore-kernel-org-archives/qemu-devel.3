Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B29FCCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 07:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJRQC-00024o-Iy; Thu, 13 Nov 2025 02:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJRQ6-00023W-Rr
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJRQ4-0006dl-Mn
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763017619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93G0n9ykQ7H5pQEE4EA3YZaOlGlgYsAOCRXxSZLaNXQ=;
 b=aXRhKx1pNTsDNmCAcbiztQA+7rXa+hA2SSpYluLW+AxEsovgpe61wT9IrnovID9z/SClNN
 CoCHgvtZT7DaDry+I2HH1VwYumGcRcf0d7FVBIA7PWyv/MLA5dVwQUSBbsy2V/mm1L6gFj
 fYuZyfleY0MjFK+kGah/2PBwZeGwLZA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-4-x0f0gtN1iQW2XWaQ5Ccw-1; Thu, 13 Nov 2025 02:06:57 -0500
X-MC-Unique: 4-x0f0gtN1iQW2XWaQ5Ccw-1
X-Mimecast-MFC-AGG-ID: 4-x0f0gtN1iQW2XWaQ5Ccw_1763017617
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-340bb1bf12aso1311864a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 23:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763017617; x=1763622417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93G0n9ykQ7H5pQEE4EA3YZaOlGlgYsAOCRXxSZLaNXQ=;
 b=AZDJGsBbtjmz2jOqR8y1jj/u521Kog7KBn/O/uMr516r01CKUF3I5qs5DskbgUjH3o
 amohFSAbYIB1TKxtCWzNNTb/hFHkTxZdSb2fOfEqSbU7B3mW9utdnvhSNLkJvOqGKoCm
 2cgZNn2FlycVZstx0Zw+rdVAw3h547MpVTF+mQTk31P90Pcirvz9e1TTKkGedoOvp5V2
 9TtGCjw9e2yv4iuxCRUd2cqAEnZJ1mAPcW+p5VolGxKV5kzBAL2DTVdYngUGyXQMFO20
 jG3l5AgDiR+yhrnDtWqZJnccbeHjYhyzJx2cM86ODLNZjrR9xLgPlfbK/P9YH9ED66Ts
 KrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763017617; x=1763622417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93G0n9ykQ7H5pQEE4EA3YZaOlGlgYsAOCRXxSZLaNXQ=;
 b=cCJbHQE2WL2csJoWryte18ftzMq/Uk8eXgKnRHODDZWeon1LY+2F+vobq+dyu8ALFU
 nCJlAmakRsY+516xXDprilZPB2VDIXeXGFQ2mVvJXN8800FV2srRZqILHcdXCSpkxvUc
 GVov2fpDiKoV9RzgkBfA7H/0Qe5UoT8gJbqo0LQR1wBBgWOEivzq62uS8AFb36RCi9Jq
 3w4ippubw6YK2LuOmHY8wFRGkdU5Lyy0/1I0gE0Ow4U6OkZJVjRE/L3T6ASpGSgtHyFL
 BCb/ZREi84ET8ytQHbehnOPwmDitqEUc7c6GFG/EBR2exT0RPOG6yNWIj+GEuyTuXHL7
 hcEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWhgrGIW67VmmepkbTXJzABGfS20bFm/I/8tf2JZmbmLtqYcBRVlIgVunjQ6fyz8KgMaCUkFITCk+n@nongnu.org
X-Gm-Message-State: AOJu0Yz1uGVa12YnF0gUnCJXmKnZJP3o2NfoPDkZmx5AQTyCX6XMQJCw
 7SOsqAAReRQC/LcHlrCBe/33pvGVTTmweIuhvMEzUO3VGzwQjRHskOhiNp7nFtePRzP7BkG8nzV
 HZcal7sZdL4z83Xfg6p32VgtuEyj19r6wcROTXpNEE9D2YhAFb0wZFAwv0U5jnDy5tS1oMkCYXp
 G5cKHhibDHP9Nies165PuzWA2CtkavE8Y=
X-Gm-Gg: ASbGncvv+M/4p9sjgKdten1/sBQjk0JXNJWcCDOYMVN1oM6icRoASun9rM9L3OYm/w2
 q5kV2NWijvz8SG5ui5BC19XqK+IeuOoSob8/BghbryJ6/LhbDeMwFJWFuKOm7YskywrcA0YSaHR
 FqhNJz0wy9XQ82z75JaxKUNO3dL7Ua1OgLKkWouN2Etm4u6O7XaScJ2GnS
X-Received: by 2002:a17:90b:4c50:b0:343:5f43:9359 with SMTP id
 98e67ed59e1d1-343ddeaf708mr6974386a91.31.1763017616797; 
 Wed, 12 Nov 2025 23:06:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbc/a2iYFU5E+sXz7pD1OcPVW4VGnGi7BJ1dktHR2pm6oR5G3vE9cHnDXNZbmAtFxngw73jCMcPcN8I8q7ge4=
X-Received: by 2002:a17:90b:4c50:b0:343:5f43:9359 with SMTP id
 98e67ed59e1d1-343ddeaf708mr6974365a91.31.1763017616417; Wed, 12 Nov 2025
 23:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20251028152400.45938-1-vsementsov@yandex-team.ru>
 <a5bfcf63-d7d8-429c-b189-a927986f8e51@yandex-team.ru>
In-Reply-To: <a5bfcf63-d7d8-429c-b189-a927986f8e51@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Nov 2025 15:06:44 +0800
X-Gm-Features: AWmQ_blntUI6KVZ4CYCb7pZoZCdKQu7kOvm7ffrp5ZfBv0P1EQLAPUN8ml4-2ig
Message-ID: <CACGkMEuyeQX6KPG1SpfLk4sShOz9K5p1xEUrUqPxrwsPig2tpg@mail.gmail.com>
Subject: Re: [PATCH v5] qapi: net: deprecate vhostforce option
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: devel@lists.libvirt.org, eblake@redhat.com, armbru@redhat.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Thu, Nov 13, 2025 at 3:01=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> ping
>
> Could this still be taken to 10.2?

Unfortunately it misses the freeze.

> Or I have to resend with 11.0 numbers?
>

Please resend it with 11.0 numbers then I can queue it.

Thanks


