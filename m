Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B9D2CDF2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 00:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRK3G-0004nH-Lj; Thu, 04 Dec 2025 19:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vRK3F-0004mm-Da
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 19:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vRK3D-0000Ic-HO
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 19:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764895918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saw2IUfAG+l3FLNXF1nwhABs9GBxXh9mZoFWqxWglQQ=;
 b=Ka8Ck4mjPrftMEXqwI8zM21mZWassPEridKQyZyoBih3S5U0m6DXpRpIPzrgRpsDA6QL36
 mbNP5Bd0r/X0uRDVkQqJzSRWMovBYvIyORur9pwo1B7xyCH0V7tKu/0vCWjUwFXZoYTcOZ
 M0dzGkrd15LdmC0BwvcFUEKU9JMPkvA=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-aTgOTz4bPrOmpPeipjsJUA-1; Thu, 04 Dec 2025 19:51:56 -0500
X-MC-Unique: aTgOTz4bPrOmpPeipjsJUA-1
X-Mimecast-MFC-AGG-ID: aTgOTz4bPrOmpPeipjsJUA_1764895916
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9353174a042so944005241.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 16:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764895916; x=1765500716; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saw2IUfAG+l3FLNXF1nwhABs9GBxXh9mZoFWqxWglQQ=;
 b=AtkTOslplN8xPRu3vnl7j5KdK0P+H38NJ09950EA1PKcNphBtTYCRXTERwz1OJhnCp
 N/91jxlLwCy3zgZ24MZRvM28fMW8vRCcV2PBD+ebfZGfNp0H9xe44BOK3e0gmmjLkBCM
 VpDNaYxOlDyWTyS+PH5xgbCZ4Yt0HeP4sw9KopRZQseiPGb6SeDQZh/t5dyYMCwt+jFK
 zhRrloUsyQZ+PvlRNu6mrtQuqdji0s1BpxZaKTKD82KNem1CWZ3zqOwlNvkz2Fir6NLt
 0OdOq5lQB9APWIhMGkfOpXytkcc+3IDUnK7gL9pUaiLmBoAuaucyOrRUNf7uu0Oh3baY
 xsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764895916; x=1765500716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=saw2IUfAG+l3FLNXF1nwhABs9GBxXh9mZoFWqxWglQQ=;
 b=uY5w7qtPFiq756gagHUS81ImYBbFt8Fg/l8VWhFx48pWcRHzblSGJnjpB6TfjQ23kZ
 5BkmWTxvh4cG54CK/iti9tdYCmzisB71xA7Nd4JOGs5Mb2ntfAuUhABmFeoPsMjDvWuX
 ZIjF5iAMCsLNi5MfdnLKaAOL+kakCdAcVhWlbWy61XgQPcSTpck6uEHvimocBvKkNa/B
 VeEUmvXPyTOWGwG/BMn0Mz8FjCLmJofEbLCmA5VH3wM9usAE0yDzSaSTaMvnE39WK82b
 0jzI4Qnug7ftgJ5H+/uFPUTQSIKBi8b31VMVfHOIWBQUQFqUHYyLNBqjcwu+bPi2IzPh
 hq3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUpAmFGkdt53FNK2R7lKWB/WJrqN9o2xovTb29F7VI4mF9Ory3mJtiTvFe2MKUDaksJP31Ki79K4NF@nongnu.org
X-Gm-Message-State: AOJu0YzESS6/VrAuO6xkC+Vx5V9JxjidPX70VrO/cvQ87CbJAhhfnj16
 bo8VaVX1Ag8g2zJvxnpktxlRNczwUM3OgPADLtUR7YasIZGGyslyMIo71vW9Zn0PqE8hUwEsmvy
 xm4qSe8IID/MKyE9a7PkovFAdZm3NeXmKnmzPpkWEr9X+Yhojmy0Vz8d6K4Kw6zc67V+h9/U/ye
 6qBVvdGSGGvcJkD4gEX3jzxCKbGmWrbJw=
X-Gm-Gg: ASbGncsDG/NDlLqFUb3Dn4pqwDNzXOCga8np9MQXGlW5kt4Ox0MlCPRD4Ev4sDAUFOo
 bAGZ98hqqE7tJapdqCvzcKW2zj0RbYdXYbd8f5T1Qzvq5fbWd37kbJNVU7R7jdUi+R/DEm5DmeD
 bZn1gpkzUpSnUZw6iO9pMSuYdq0VU6Syoopw/DjF6MJEQRKncbHz3XOK+60L8T0Fe7+w==
X-Received: by 2002:a05:6102:32c2:b0:5db:3d11:c8d6 with SMTP id
 ada2fe7eead31-5e48e231773mr2725294137.5.1764895916070; 
 Thu, 04 Dec 2025 16:51:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5u39XBguip75m2TlnnVk6Xru4fRR+ZgzogM1MYzDp91AepkzInpF630KRNFbFfBXN3bOsLriOnD5AxdEMvzM=
X-Received: by 2002:a05:6102:32c2:b0:5db:3d11:c8d6 with SMTP id
 ada2fe7eead31-5e48e231773mr2725289137.5.1764895915632; Thu, 04 Dec 2025
 16:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com> <874iq6mzx5.fsf@pond.sub.org>
In-Reply-To: <874iq6mzx5.fsf@pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 08:51:43 +0800
X-Gm-Features: AQt7F2pxNexINFqX7kCmBqxUEhIqxx_x39inFA0fmk_sN9d6z7lYliZtnUgbomI
Message-ID: <CACGkMEs0cNNYewaEnMVVWr8ng4kRJGotqwk5O1z1fs4BTnzPhQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] tap: cpr support
To: Markus Armbruster <armbru@redhat.com>
Cc: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>, 
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, Steve Sistare <steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Markus,

On Thu, Dec 4, 2025 at 4:09=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Ben Chaney <bchaney@akamai.com> writes:
>
> > From: Steve Sistare <steven.sistare@oracle.com>
> >
> > Provide the cpr=3Don option to preserve TAP and vhost descriptors durin=
g
> > cpr-transfer, so the management layer does not need to create a new
> > device for the target.
> >
> > Save all tap fd's in canonical order, leveraging the index argument of
> > cpr_save_fd.  For the i'th queue, the tap device fd is saved at index 2=
*i,
> > and the vhostfd (if any) at index 2*i+1.
> >
> > tap and vhost fd's are passed by name to the monitor when a NIC is hot
> > plugged, but the name is not known to qemu after cpr.  Allow the manage=
r
> > to pass -1 for the fd "name" in the new qemu args to indicate that QEMU
> > should search for a saved value.  Example:
> >
> >   -netdev tap,id=3Dhostnet2,fds=3D-1:-1,vhostfds=3D-1:-1,cpr=3Don
>
> Hmm.  See below.
>
> >
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > Signed-off-by: Ben Chaney <bchaney@akamai.com>
>
> [...]
>
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 118bd34965..264213b5d9 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -355,6 +355,8 @@
>    ##
>    # @NetdevTapOptions:
>    #
>    # Used to configure a host TAP network interface backend.
>    #
>    # @ifname: interface name
>    #
>    # @fd: file descriptor of an already opened tap
>    #
>    # @fds: multiple file descriptors of already opened multiqueue capable
>    #     tap
>
> Not this patch's fault: the interface is misguided, and its
> documentation inadequate.
>
> @fds is a string of file descriptor names or numbers separated by ':'.
> Not documented.  I found out by reading the code.
>
> This violates QAPI design principle "no string parsing".  It should be
> an array of strings.
>

I agree with your concern. Just a note that this "fds" was introduced
before QAPI if I am not wrong.

Thanks


