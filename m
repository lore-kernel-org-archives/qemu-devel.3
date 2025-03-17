Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5DFC28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 00:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttyTe-0001ho-OJ; Sun, 16 Mar 2025 20:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ttyTW-0001hD-JY
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 20:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ttyTV-0000RF-3h
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 20:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742171818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fgebysWf0lPGNZlaalXmtawqCO2uSQo6km2bL4Ozdw=;
 b=BfdyeXQ8A2uftedUTE05U8atx9sZ26GoHkorhjbsQ0fTsvF8pDo21cJIsT1AtQSyEPXRsq
 axWdzpE2RIVeqEFX7OXhrHyLqwHPqZsUaFu5tlyPK40QOHghlq8wP2qeJHXCLfQ9JV/3Y/
 MfezVcZWXDQFwsY9d2A4t4qOJqG5KoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-VJH8hlV5OCCRJDOSdNyVjw-1; Sun, 16 Mar 2025 20:36:56 -0400
X-MC-Unique: VJH8hlV5OCCRJDOSdNyVjw-1
X-Mimecast-MFC-AGG-ID: VJH8hlV5OCCRJDOSdNyVjw_1742171815
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso10705775e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 17:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742171815; x=1742776615;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fgebysWf0lPGNZlaalXmtawqCO2uSQo6km2bL4Ozdw=;
 b=FsMZZ8TnI+DyNKFOe0rczhKsLh36qfYMHK7mhMbJatfq4I+XWBea+AhouED6mq0CKJ
 EMqE1pYtp0lGDvPbYIAGW4nnh8n5vpV8ziQpFKcwvcUv6E9FzGdY9PnIPhc9xPGdciha
 U+8Km73x8rRkSPxsF9DZrhCo999NYmG/4NPDHRw2LVVKOiikVevsLMuHC7mcf27KmjcT
 4DucaaSUUBKRtAFafJZoAEchXs28IBjq7cx62eh94Lm03NR44DKYkuxAN891NAECEKyk
 TduKddySo0jJifY/Vbyy1PSLWF1mq+NfgdGHAd0IurqsK7ftF20K8FnY7/CoOS+r0dLB
 7XCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5alcYw/TMY8R764CxgWSLPTsDBCxt1zil7J28oqLaK24rtTk0gke2htJBbSjKCKCyVEP6aDwY8Ykg@nongnu.org
X-Gm-Message-State: AOJu0YzRaiY99jgPLWrpR4PUPcxklpG1662N6aBu1jzg2+Xr/ylptPNF
 ZVzj+WW/xrLvy0YvwxXNaWEVbNJ2OkQep4Z0YAAhiX9ee/1rOsM1DMUiVYs3pG4atLdG2ASW8ki
 HQaOKygVJpG1gn+lK4Nh037rrS8DoVPubqMtgdJdUt+v2/cQ2uRYv
X-Gm-Gg: ASbGncsPkqYT5N+IKe1GTZTlAGaAtnLuzMGDShQ3A4jjXegodAa2zH9L6x6z9H/KtBO
 mWYY08gfLiCdy1vGByydqiQFsGAokHDKV8eEcprx2u3yvpWkFXTn9igVbxQLZVLY2UfbmRnMesX
 cAC6+nS1/0KiE4N4jTqlkrdtc09Ko2zEnEzzo0bE/Hsz5Q5f1ptoKB/uBI2xkBcSYeKSU7+WPyE
 4JnjmhJaSJF56o2umlkLu9RwUblLvAQz43wz+J4ptRdOim4AH0ue3U9JdWKZ+6XZ3bt8/6IO7Mu
 vOWGVoy2Qw==
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43d1ecd8631mr103936545e9.20.1742171815025; 
 Sun, 16 Mar 2025 17:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHogb6FXpoWwAh/ITekqmz/MwTnZXLb57x7zFqXWm5iI6ut3KI9wPc+ZpPNBBdQY4zeIa364w==
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43d1ecd8631mr103936435e9.20.1742171814640; 
 Sun, 16 Mar 2025 17:36:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm90158515e9.17.2025.03.16.17.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 17:36:53 -0700 (PDT)
Date: Sun, 16 Mar 2025 20:36:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, eperezma@redhat.com,
 sgarzare@redhat.com, mjrosato@linux.ibm.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] vdpa: Allow vDPA to work on big-endian machine
Message-ID: <20250316203639-mutt-send-email-mst@kernel.org>
References: <20250221190733.490308-1-kshk@linux.ibm.com>
 <CACGkMEtm5gapBTmM_cA=jxAEg4GMkyMf4Wa47kvkFvN05uJ__w@mail.gmail.com>
 <0ea107ce-82f1-4333-b766-fda8e0cef454@linux.ibm.com>
 <CACGkMEsrFoQ9QXYPAGDE6p7FOK=a+vAUv4FePZOkTngn1izCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsrFoQ9QXYPAGDE6p7FOK=a+vAUv4FePZOkTngn1izCuw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Mar 17, 2025 at 08:26:37AM +0800, Jason Wang wrote:
> On Thu, Mar 13, 2025 at 11:14 PM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
> >
> > On 2/23/2025 19:57, Jason Wang wrote:
> > > On Sat, Feb 22, 2025 at 3:08 AM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
> > >>
> > >> Add .set_vnet_le() function that always returns success, assuming that
> > >> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
> > >> outputs the message:
> > >> "backend does not support LE vnet headers; falling back on userspace virtio"
> > >>
> > >> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> > >> ---
> > >> Changes in V2: Add code comment.
> > >>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Is this patch all set to be eventually integrated, or more review is needed?
> >
> 
> Michael, do you want to queue this or can I do that?
> 
> Thanks

Go ahead.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



