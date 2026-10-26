Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA1606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3XxETOU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLEpd-0003Ai-6f; Mon, 26 Oct 2026 03:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpI-00034L-Ta
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpG-0000bg-V2
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792998537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYEAXVasBgk/+sN/Ns9PhLk4aUImSGj3VSlxJQXN+GM=;
 b=M3XxETOUjIdODVPl44Ze8tlbaiLcuUx/pmfFqHmDKABx1Nd5074cel5siL2OR5opUgp3/w
 cL7XhLj/XaF3Qmlbpx8Hg8pdD9xZdd5urX/lPfKT+YHeKIQSWYUaunY1LRN7v0g5f+fvVx
 drWTZxeJe2t+/EiVSkD2nC1z/+ArAOg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-NUuwCR4iPHKKQ49ZChzzow-1; Mon,
 26 Oct 2026 03:08:53 -0400
X-MC-Unique: NUuwCR4iPHKKQ49ZChzzow-1
X-Mimecast-MFC-AGG-ID: NUuwCR4iPHKKQ49ZChzzow_1792998531
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96F8E18005A2; Mon, 26 Oct 2026 07:08:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7226B30000E3; Mon, 26 Oct 2026 07:08:50 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 6/8] hw/display/tcx: validate blit source address
 against VRAM size
From: marcandre.lureau@redhat.com
To: Tristan Madani <tristmd@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, hpoussin@reactos.org, arikalo@gmail.com, 
 balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de, pbonzini@redhat.com, 
 fam@euphon.net, mark.cave-ayland@ilande.co.uk, kraxel@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261025173625.3372689-7-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
 <20261025173625.3372689-7-tristan@talencesecurity.com>
Date: Mon, 26 Oct 2026 11:08:30 +0400
Message-Id: <179299851014.907607.10986173061965362599.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=585;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LHL2hadI5aVRy32cusVRKbKxdY57i09McDI/x+N/Yuk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3vxw5/GZNQDNn++UVEFy5DlF/4l3YEVUEpIPe
 CnIqwA/8ZiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCat78cAAKCRDa6OEJdZac
 5a3BD/4kDSxjIvxckJ7l2mXq4p6YwIZQ/oNXIPW6Dgc9aDMptVoqbKKb1gWzz2eeV/MlSB8yaG9
 h6RuioLUekG29IvvaHzIvlrBbIzyCcdTv9Cu9N7pYiDca/SdkhcatmEzP6N8qxeTsuntsixh9KL
 OEnpMeou0sTGlYMR2QnRNMHDOWKKD5RkVtd7uubjgDjPoLrxxds477qLOpeSS2M7S41DZeh+3qY
 lT3w6ZFDEexj8rAkC/mHpOETXVbs29lrZlcGCz3DE4GWEzcW/38TjhtWeO9UsMrXe8iMXQt9XGI
 NPzeqqEDwCBfU3U4PP4VmB6tlxyaCO9wpRj7CzkbdMwBrxfVG28EBcKkAz+42L6Xv94pyF0uoN8
 wSTRim4qFr8xpNfS/0ojlo1wgRqT2A8y03Hjt3aN7ANKLVoUb3lLgOIx10+eUW+pmvOxN3DgdSS
 7EI9cb33J2wPwA9SiThFIV95FUHKZ0HWMYdjA17GQwQgU/FcTPyJfXXTk/tEpwLvslRWQePOapY
 QO/U/THsB8m0MJjZt1f0+kP4Mt/n71eDQnIwKNYy+YG2Ite9RmmuAih1nkpYWyL0n3bZXIJBt1J
 9j5bIr+nVQsNYf1JBar+/Gv6rW8MtHp6Q6fTFwXsQ7nsj93fvRdFjgHiNcK5XwFbYywCwKYU+cS
 LGNQTZMkIN1VpWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 17:36:23 +0000, Tristan Madani <tristmd@gmail.com> wrote:
> The TCX blitter's source address (adsr) is extracted from the
> guest-written MMIO value as a 24-bit field (max 16 MB) but never
> validated against the VRAM allocation size. The standard TCX VRAM
> is 1 MB with a total allocation of 9 MB. A guest can trigger a
> blit with a source address up to 16 MB, causing memcpy() to read
> up to 7 MB past the allocation.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


