Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6A606A338
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MtEySzQ0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmjR-0003De-Vn; Fri, 13 Nov 2026 03:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmj5-0003BL-Py
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmj4-00038x-4w
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794558817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylA2c+p8uZ/RlhlFgXISudbd3iA46rghX4pAESRcBZU=;
 b=MtEySzQ0vuQvAmwcb4qkpwaJDYjTTgaP3U+JAw2zRe92a0FvCyOvi1XtK7F8KcjM/83pF6
 bgp6C/9Qx6MOJz7rvckQUjv0ZmMIWP6lLzYdYn9bAFNW6t24GaJMcptx43wIzC6zcLbEUh
 CYySjOd1I01VpDWmqoVp2v87cGZjLKA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-nUMHCnKwMJicDUYk0njBpw-1; Fri,
 13 Nov 2026 03:33:15 -0500
X-MC-Unique: nUMHCnKwMJicDUYk0njBpw-1
X-Mimecast-MFC-AGG-ID: nUMHCnKwMJicDUYk0njBpw_1794558795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA541956042; Fri, 13 Nov 2026 08:33:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8DF91800542; Fri, 13 Nov 2026 08:33:13 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/9] hw/usb/dev-mtp: Handle invalid characters in
 utf16_to_str()
From: marcandre.lureau@redhat.com
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Junjie Cao <junjie.cao@linux.dev>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-stable@nongnu.org
In-Reply-To: <20261112174907.158825-5-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-5-tcalifano@redhat.com>
Date: Fri, 13 Nov 2026 12:33:00 +0400
Message-Id: <179455878072.754321.10848127829960266585.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HOT9SkvA0ykcetaPYmhWE9fCB0jSlq48xTOBWYEgMXQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9ss/Dl0wYqSpbeBJZAzqDS7d6ng4EsGPEeSWU
 TPjoEr2eyiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbLPwAKCRDa6OEJdZac
 5a+jEACKAinEkRf4tiE+Asub4fk+0fljbfY7hgXtHN4Wh598DBPDQ/y28C9smtrx+OCUpCnktu7
 95KifdgBr4HV+mFi7jy6EE7x82XZen//bQS2eF0it3YAZB1Wvzwzqo0ywupmhAMEkhbfK7HL2vZ
 ITVxHqy7A6BwTs3OzVYDmeP3eCWm37t7xlnA+FCdnBH64BiJUdeJqB07jRSGx2lKH/fXRa2++W2
 PQLhS+DhRco4XNT44ggCUj/bUpqoEK5LSWa8Je2iYFOH4p801K/Nl5uf9ZJR2ue8qmmRUJbUFEq
 xJ01doNFAWuarazM+XwRmOwp1QiuKVZIvLl4HD7Ok/AGBm64Uj0ILRnPHVTzQaYMU/afjXUeiRy
 iVU4ZDXuS8lBc3MIAcNi7OUGeXN3fk3t8UktGlSBS6OFZQuu7QUsP5kazBnR9StFah/3XSlGfeE
 Jy83+elK/UevJlUWg9aww8cfuv7KZ/1zUgErELYTYcXu1kfMNlVHm97g3YqUlqkfyFCP/89gEcH
 LifkJXZRAzwCs4XN+uSn1KBhKG9RXI5onRt2jRx8K6hUxxvpFjkq6wSCclhrUIJy0n4sQUrYw0Y
 nnBwEgieK3OOT0A3ZBw4nvGocfDwVjcV5zJZ05qokxwB1wZnkXwhMj2Fqopdy/BE2BLTkvU68m2
 XfDFCD41FPxEmCw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> wcstombs(NULL, wstr, 0) returns (size_t)-1 when the string contains a
> character that cannot be converted. The return value was not checked, so
> dlen + 1 wrapped to 0, g_malloc(0) returned NULL, and
> usb_mtp_write_metadata() dereferenced it in strchr().
> 
> Use size_t, return NULL on conversion failure, and reject the
> filename in usb_mtp_write_metadata() when that happens.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 6de02a13232a ("usb-mtp: fix utf16_to_str")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
> Suggested-by: Hui Peng <https://gitlab.com/benquike>
> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
> Message-ID: <20261112174907.158825-5-tcalifano@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 1a26f681ce5f..7233470558db 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1563,7 +1563,8 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
>  static char *utf16_to_str(uint8_t len, uint8_t *str16)
>  {
>      wchar_t *wstr = g_new0(wchar_t, len + 1);
> -    int count, dlen;
> +    int count;
> +    size_t dlen;
>      char *dest;
>  
>      for (count = 0; count < len; count++) {
> @@ -1572,9 +1573,13 @@ static char *utf16_to_str(uint8_t len, uint8_t *str16)
>      }
>      wstr[count] = 0;
>  
> -    dlen = wcstombs(NULL, wstr, 0) + 1;
> -    dest = g_malloc(dlen);
> -    wcstombs(dest, wstr, dlen);
> +    dlen = wcstombs(NULL, wstr, 0);

Can we replace this function with g_utf16_to_utf8() which is not
sensible to locale. If not, a comment could be useful.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


