Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA8C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD09t-0006Br-1H; Fri, 31 May 2024 07:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD09r-0006BL-DR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD09p-0001GZ-QD
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717153848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+s1PzK2/wvRT6JuH6Q8j0YjcXC2Cl53mqKVRaXl/lI=;
 b=A0gjG79nUe9sgBxH14BV3cYWHV7Dk+gh0M6v01T8K95PhnrY6QUbWYlmU02oKYinbEYY0G
 oRtSqMMPnqIo65gwNDjAtgGAWpL61jGoCONjC3FD/stYge4AgebpRkf8gHq6p5lTKwtsEs
 D/cc0s4CD1Ewz0pD8vERuBprpYFQNj0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-VHyBcsajPmGozCGMK9Rd4A-1; Fri, 31 May 2024 07:10:46 -0400
X-MC-Unique: VHyBcsajPmGozCGMK9Rd4A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35e0e59dcf7so368464f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153845; x=1717758645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+s1PzK2/wvRT6JuH6Q8j0YjcXC2Cl53mqKVRaXl/lI=;
 b=VO5iAB9Oq7mc0bg1DlUpYx+WIlr3Oic304zTie0I3yYCNFjeJfzq6iPJfncWlQogMz
 TiuAqo9RuKE6SBFHjH4IGQoFpJxtjn7ghN0hFusmlNomyhAgobgo8te9yNzxbXFNmQL9
 U2UFm3TJ4zBQDKkujSJY8FhgpKqcqhen40ul9FfSP1PHRjTOWpU8Zneep8DYceDG1OSx
 98jOeBPOL9OgAKDdAh7tdgt+Es/DkG+kDfFZSJlGpcA9mDQcLmVA5IU7FZybtPtWDVUc
 m0C5hjooYkUlmnXXxKFBN97NKwa3jBH1h8UMP8iOzAoIPHovfrTRoQGkF9N/mU/EI46Z
 hFng==
X-Gm-Message-State: AOJu0YxE+CeoZKAdGuFmkdlVLAVItGcLS1zLEf8fXmVJgwpHNknNKyUy
 rrVSMOo4RUjp7a2cMaVfydbDArZHXtxkxWrf+b5a6iSCKOlL+yOlVBOkKXnA0ZIpywDYUKs+JK0
 z0/WU9QhhVA3R6ba6am3GQZFU+K8OUQrNyIGvqXIprbmn0arDSy/T0dtdVlOkDVxN1wXTX3Uff1
 Sn+rRWSjSPXzA71ogCym1Y4F3phxw=
X-Received: by 2002:adf:a196:0:b0:355:21f:be29 with SMTP id
 ffacd0b85a97d-35e0f258a4bmr1049570f8f.9.1717153845351; 
 Fri, 31 May 2024 04:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx/etlVUJlB9WKitCYPHHqZ6AY725KQtDuX2iOQ9gGvuUQYbjyjYV6+5KlxopoiK8PzYToffzVKP0Nb3mspTY=
X-Received: by 2002:adf:a196:0:b0:355:21f:be29 with SMTP id
 ffacd0b85a97d-35e0f258a4bmr1049539f8f.9.1717153844842; Fri, 31 May 2024
 04:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-26-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-26-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:10:33 +0200
Message-ID: <CABgObfYrg4pJMo9RgY-V5iizviLqWFohPqUUU3wtK5cVHdsS=g@mail.gmail.com>
Subject: Re: [PATCH v4 25/31] i386/sev: Invoke launch_updata_data() for SEV
 class
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>
> Add launch_update_data() in SevCommonStateClass and
> invoke as sev_launch_update_data() for SEV object.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>  target/i386/sev.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c5c703bc8d..7a0c2ee10f 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -102,6 +102,7 @@ struct SevCommonStateClass {
>      /* public */
>      int (*launch_start)(SevCommonState *sev_common);
>      void (*launch_finish)(SevCommonState *sev_common);
> +    int (*launch_update_data)(hwaddr gpa, uint8_t *ptr, uint64_t len);

This should receive the SevCommonState, so that
sev_launch_update_data() does not have to grab it from the
MachineState.

Also,

> -        if (sev_snp_enabled()) {
> -            ret =3D snp_launch_update_data(gpa, ptr, len,
> -                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
> -        } else {
> -            ret =3D sev_launch_update_data(SEV_GUEST(sev_common), ptr, l=
en);
> -        }
> +        ret =3D klass->launch_update_data(gpa, ptr, len);

this patch should be placed earlier in the series, so that this change
is done before snp_launch_data() is introduced..

That is, the hunk should be just:

     /* if SEV is in update state then encrypt the data else do nothing */
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
-        int ret =3D sev_launch_update_data(SEV_GUEST(sev_common), ptr, len=
);
+        int ret;
+
+        ret =3D klass->launch_update_data(SEV_GUEST(sev_common), gpa, ptr,=
 len);
         if (ret < 0) {
             error_setg(errp, "SEV: Failed to encrypt pflash rom");
             return ret;

Paolo


