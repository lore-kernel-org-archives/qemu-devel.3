Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE1CCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqGG-0002sm-Kl; Mon, 20 Oct 2025 09:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vAqGD-0002sO-TB
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vAqGB-000401-Gx
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760968149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bc6cE2alQ7Jvw0zLHsCJHPNO0E7TeHw5j37Rexdz1Eo=;
 b=VhK7P5GjAb0GJWimPV0Yy9Zkf5bBUZpAESm/kevUheJ3/f4D9TK5Yn9PPHzLhgx7Sfzwog
 f4OstRs4qNVzDqXutM0N+u5aEI6yFFr/swBUSpuBA5t2EoPQoAslGZHs05LdnsO8a8Tk3Y
 42kNcbCtBy6Fvr1NKWuk7m+vj212Zb8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-pJUSZ1uaOKa5nySXQQn5Uw-1; Mon, 20 Oct 2025 09:49:07 -0400
X-MC-Unique: pJUSZ1uaOKa5nySXQQn5Uw-1
X-Mimecast-MFC-AGG-ID: pJUSZ1uaOKa5nySXQQn5Uw_1760968147
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-81a8065daf4so81029316d6.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968147; x=1761572947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc6cE2alQ7Jvw0zLHsCJHPNO0E7TeHw5j37Rexdz1Eo=;
 b=PLYi130HA3fRjjgg5aYe5sIH7J65voIw1IPVpUfqZjjveHe9Dkq9NLlplzig1sQJI6
 VQCQGTpPU8IKnj7p7AnBsapB2KU5BDFw6oHNR86C0dEIbNhPSg/DwuIy+VfGyqGle/pp
 7ZeSb4a/y8eAqgOPsweq9SQmE5i+MGchP5ztMFi222pm+Is6WhJEowgtlmwh+YgW6roB
 aUvo50qVV/R/J+zA+rt09KrIBDl0oxuDcBw/OT21Ipi+I5xUeUOkufAX+IAOyvnz1F8j
 FgNeve0iW27LSx5fv7Yy+MLqtUx+FkSFvu5OoTG9Ci0VNzxDsfUgLvTS0WejjT81sX/Z
 05ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgRwPsniksMHQ+ph5z8/7vflHUynfkDLiZg+yNAeH13IY7uC2eE2lu6DVNrlnRmVoaN0KU25tN2ze2@nongnu.org
X-Gm-Message-State: AOJu0YwEyyqZoP8R30wd6WWKxQvw8FICLm6YIvLg17SsYGpwJ1wF7W/x
 w0c13+Sp1JkBa3ZRniwsKEUj0XjFhPG02FR63Q/4wNfm3CaUf3uvZzllyUit5CnGYsrSm7k4pkM
 lcBbYAehb2plCsGgiL6mZyIc+2d1oe3dRk9Ee9WibiywH+t2y/O7v7Xpv
X-Gm-Gg: ASbGncuIkQ18KcMWQMbyMG8lMszU6iWM/NJU9nw+5/sUDtGiWnsdwybygkyzhKeNlhH
 GUnDbnfFXOUf0mpU9JfjJRiYVAFh7K1Udg5A2j/783UcK50XX1QB82V3DBoXaNWgESJiw1dqwkT
 RkPwMJ2D1G4Ee5s1wX9oN5AyQD8+ekTq9dFyxfqoz6qHRAnDzSdQzFKM47RGkaO0UGV76haHmqa
 8IYuesOJwY77LgfFmE1YsbSXon5G7fIIuZkpxwm3ROuNiCp8SPX9Sw/MES2p7CekjpwO3vMOFGD
 e90cmbc8j+XLp8imtKRDdmc7qyvBdEsm3687bV2TUIDtF//ikGKmilj1+7CEkzMoFKc=
X-Received: by 2002:a05:6214:19c2:b0:87c:124b:774d with SMTP id
 6a1803df08f44-87c2056b02emr168043796d6.17.1760968147274; 
 Mon, 20 Oct 2025 06:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Z7N+DPwIh5s5Ukl4do46t5XqLcjQLV96bTlgj1InQIQpmQZfniuKfMsyhHohQnaRRIOi6g==
X-Received: by 2002:a05:6214:19c2:b0:87c:124b:774d with SMTP id
 6a1803df08f44-87c2056b02emr168043476d6.17.1760968146829; 
 Mon, 20 Oct 2025 06:49:06 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d0288488esm51141806d6.34.2025.10.20.06.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 06:49:05 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:49:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
Message-ID: <aPY90JnJtyHZUUuq@x1.local>
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Oct 20, 2025 at 12:19:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> @@ -255,13 +252,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
> -    if (vmsd->post_load_errp) {
> -        ret = vmsd->post_load_errp(opaque, version_id, errp);
> -        if (ret < 0) {
> -            error_prepend(errp, "post load hook failed for: %s, version_id: "
> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
> -        }
> +    if (vmsd->post_load_errp && !vmsd->post_load_errp(opaque, version_id,

I think this will change the semantics even if I do not expect a real user
to exist.. if post_load_errp() returned true here, then it'll keep looking
for post_load() and execute.

It might still be good to keep the old semantics, so that if
post_load_errp() is provided, then we ignore post_load().  Same to the rest
hooks.

> +                                                      errp)) {
> +        error_prepend(errp, "post load hook failed for: %s, version_id: "
> +                      "%d, minimum_version: %d, ret: %d: ", vmsd->name,
> +                      vmsd->version_id, vmsd->minimum_version_id, ret);
> +        ret = -EINVAL;
>      } else if (vmsd->post_load) {
>          ret = vmsd->post_load(opaque, version_id);
>          if (ret < 0) {
> @@ -438,9 +434,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>      trace_vmstate_save_state_top(vmsd->name);
>  
>      if (vmsd->pre_save_errp) {
> -        ret = vmsd->pre_save_errp(opaque, errp);
>          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> -        if (ret < 0) {
> +        if (!vmsd->pre_save_errp(opaque, errp)) {
>              error_prepend(errp, "pre-save for %s failed, ret: %d: ",
>                            vmsd->name, ret);
>          }
> -- 
> 2.48.1
> 

-- 
Peter Xu


