Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA5AC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfklp-0002sz-BP; Thu, 29 Feb 2024 13:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfklg-0002nx-Mx
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:04:29 -0500
Received: from snake.cherry.relay.mailchannels.net ([23.83.223.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfklY-00082S-1Y
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:04:28 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0DD6183495
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:04:17 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 3011783CF0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:04:16 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709229856; a=rsa-sha256;
 cv=pass;
 b=Et76rEYc7oSupiYqp540EnZDDZagjBdC7Qhuf50x3+Rt0kVI7EZYjMatITXbX/A6Oo1rJF
 6nYXfN04Vj4ollW14uzCzJt63hTBOJi+VQbx9U4Swiz5q3z7eE9j+wxTWWZ022RxdnMmkx
 jtPuQafjSDdkLuo2GM2CvkGgeUCI1a1zLGmGeinG+lofd0UktpiiPnGZq7uakA3OTi9NUq
 cKk3XYctTZ7cJNa6y6BkYXaiXnhrzQ8gGhER+nYmOGaFqlDYZJQbrhl+pMQWuFPucryoiJ
 gX0b+YIhETY3u1gVGHiCeLeH8lMcAtiid5Y9IUjTuLugrUVvajLHr6/7xfssJg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709229856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=/wumxogzyOumUdTcGyRHuGOW8RASzXcjGdXHeiNMITE=;
 b=gcQU11sMUwRYu19AzN9EZD7QpAAwwZCcDmQeQBUgu2QNPg8/DfoJEWsuVWsQEkEUYHg+0Z
 UNC3x01GJDMzDbika5PVzYS4aaP+Ylfpl90VxVbInSLlILQ4yV0D+Munkm5fLOIxWl9Hc8
 WHbdMR7LA+L3L3Jr4VibI60opCfZ8pc193R7gA9KXWMA/fi5sZkvgVyy7JxDBPrFw+UhBE
 ne7X0f9w2WS9zb6eoF5nsqvjyquXIhfnd9sKPwR0rPngXJEHfAU0WWAzOQLiRkzE9kbOZ8
 +ZbFtqq1LV5JuE/lU0bkMfLoLnxQamPoJrZOAo6Y5SnbDecRtMbH+o1lwN+o3w==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-smqdl;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Harbor-Harbor: 594b42c262c546b3_1709229856686_3153848249
X-MC-Loop-Signature: 1709229856686:594268258
X-MC-Ingress-Time: 1709229856685
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.58.46 (trex/6.9.2); Thu, 29 Feb 2024 18:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709229831; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Y6nCpJ/aK/YVC36kkCP/GDmhGtKtE7cAogvQE30895FBDEo6pKiCtVaLgunkcNaGHbN+SWvCEzBKO
 W8WzhHZObrZYe+ckpbyBbm1Jtupg++vCSPjwUEh0wfAJYrv7cjjbu21qCOV+d5SXzgwtzVBxB3oAUq
 C8ZwCfarmU/q8+Ru/9NuboO44vCVnZs1lxetBSTbdVVZs4QbZHN+nzsZniKoVW5tVIcqvB+WKOm4jf
 LALFuJ7ttbQ8fTm4/+vsgL0dnGHbePkCD4yxnJeb0HJgd7DBiLyVuY5xd+lR2jc73A/wn3VDzR9sgk
 UlYgPvozU8/Rw+oJNFAgdGWULhRlTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:dkim-signature:dkim-signature:
 dkim-signature:from;
 bh=/wumxogzyOumUdTcGyRHuGOW8RASzXcjGdXHeiNMITE=;
 b=K7DlSvSeQNBawoTEaJVWphfbQ5tuIvfs7pmuCph3um5ink2scY06Aj2JE91AqKri2tfZCrU7i+EZP
 QYvxEXuWdheBubV5xkii6UIrGsjSxw7+PJSZRF4rwoPdhrZEDjN81G59T5iDJupSX3DoLbS7jvmF/8
 aqsqbPg9m/uvFuNWu0ZqQMX8Z67BSufWoRk82tjgIFWt2xxqui59j41LBg2DRyHS5g2T/XiA+o6Xjp
 zriAQ9tb8xuhEP9Kbm3qAV422E7Ddi86gnbo7q7Xy/l6OMe9T2R6oqMw1rXebGll8esshQ5GGDVw2c
 1NpmroTabXR4X3NkqjgG3aVdDN0oB6A==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=J0U6mcZd; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=/wumxogzyOumUdTcGyRHuGOW8RASzXcjGdXHeiNMITE=;
 b=ZXzzSDrDpVYQ2TtneN0inUFdGsqbLMGT3tHWlyros60aH9PHOYxOZHZxtNZgL3XRHuSFFNL27AiUr
 sdojN5ZXW463T0g+bd7ILVrMK/Xl7LeYrw7M1ulwToIm6lY35vL+Smuh6JA109qzg7c3R2yU/VtuDp
 FSpUioIn7KRAhxN4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=/wumxogzyOumUdTcGyRHuGOW8RASzXcjGdXHeiNMITE=;
 b=FtIBBgTpO3zEsFf6IDdaoZjNhyvq7j4zwo0AAueDpFXUiov6OQ1//sTKOOyPhldn+hkFoCvDMULcd
 PHXSgJdHLBnCb0PKAHV170scwA829uoJna6iWcDR+rePqRtBv/YSIbku4oDQIKFGVI7euJTw+bDTk0
 WjX9HFkH4L4uTxlg/POy9xLOE3CmHgZ+XnagsVHRTJkTJK5C2y7BVj353i841cDMvse5gVRxowMoD6
 nRbn0vSphfnrx9jNurDVeVDgPYLHOobddTO9Y1NFu6Z7FSMrFgeXuqKuv2h/mIh0F3zoaJwNvWJB7V
 GNa+orByPpyqTEEigT3AD+nipzLVWHA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: e14fe26a-d72c-11ee-afbc-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id e14fe26a-d72c-11ee-afbc-eda7e384987e;
 Thu, 29 Feb 2024 18:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/wumxogzyOumUdTcGyRHuGOW8RASzXcjGdXHeiNMITE=; b=J0U6mcZdVCknG5g7YXnAcFw3JZ
 iGiRWA0HtqPywZYMgcF48xRBz/GB6uQIm6MWQ92BS0qJzvDy36h3IxJ8NKVZvuDPD9N8wwD3DrwIU
 uJgUr1a9wqHtPC3S6byVFXTape6QG3AZsAfTaR8EsenlWh/4+D5uSotM8fQeUYARO8K6KylOQnA0K
 6COHF8lY9tEODoYf+LzNWHvoLn7WCM2JtRGOuOoJKjQISJet4Sn70qTiBO3+981JCTAvazfi6ZEZE
 OPtok3/9irf30c5I3L/194cp/aMFsw0E86ncz8EtqzOvSFpjnLPU2BGNR3VqOBlKGGdwT+LENZ4FI
 GNOgBNHQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfklN-000MxS-0Y;
 Thu, 29 Feb 2024 19:04:09 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH 3/3] plugins/execlog: add address range matching
In-Reply-To: <874jdr6vp5.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 29 Feb 2024 17:12:38 +0000")
References: <20240229150729.1620410-1-svens@stackframe.org>
 <20240229150729.1620410-4-svens@stackframe.org>
 <874jdr6vp5.fsf@draig.linaro.org>
Date: Thu, 29 Feb 2024 19:04:08 +0100
Message-ID: <87il27xi3r.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.83.223.171; envelope-from=svens@stackframe.org;
 helo=snake.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Alex,

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Sven Schnelle <svens@stackframe.org> writes:
>> +static void parse_vaddr_match(GArray **matches, char *token)
>>  {
>> -    uint64_t v =3D g_ascii_strtoull(match, NULL, 16);
>> +    uint64_t low, high;
>> +    gchar *endp;
>>=20=20
>> -    if (!matches) {
>> -        *matches =3D g_array_new(false, true, sizeof(uint64_t));
>> +    low =3D g_ascii_strtoull(token, &endp, 16);
>> +    if (endp =3D=3D token) {
>> +        fprintf(stderr, "Invalid address(range) specified: %s\n", token=
);
>> +        return;
>> +    }
>> +
>> +    if (*endp !=3D '-') {
>> +        high =3D low;
>> +    } else {
>> +        high =3D g_ascii_strtoull(endp + 1, &endp, 16);
>> +        if (endp =3D=3D token) {
>> +            fprintf(stderr, "Invalid address(range) specified: %s\n", t=
oken);
>> +            return;
>> +        }
>> +    }
>> +
>> +    if (!*matches) {
>> +        *matches =3D g_array_new(false, true, sizeof(struct address_mat=
ch));
>>      }
>> -    g_array_append_val(*matches, v);
>> +    struct address_match *match =3D g_new(struct address_match, 1);
>> +    match->low =3D low;
>> +    match->high =3D high;
>> +    g_array_append_val(*matches, match);
>
> This is almost but not quite qemu_set_dfilter_ranges(). I wonder if it
> would be worth a light re-factoring and then exposing the parser as a
> helper function?

Thanks, I'll take a look. I wasn't aware of qemu_set_dfilter_ranges().

