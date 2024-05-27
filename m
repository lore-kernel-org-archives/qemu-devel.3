Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA10C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXne-0005bh-Vf; Mon, 27 May 2024 06:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBXnb-0005bQ-FD
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBXnY-00004v-MH
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716806507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVQgMx+OXu/Tr4PbzpMH44lS6YIly7mn3Ni9DxgBxgc=;
 b=F8Pl+wgOvXYlqXXE6lIA8vb4s0GTe0oD8MHlq4zo6RfFUSq5/QTq9xSsB6wmQ6P7baWxe9
 vNVgoaPpaIo1upkk2gnqsZ4PDsy9E8brc2o8ZHFKYDWoUT+wXcmB3tVt9b6NN49Tyy730x
 Vt2M+5X49OCNV9gnIxs8ZDnuN2Zc3d8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-MNWXdEdYP5G7PizNudo_hA-1; Mon,
 27 May 2024 06:41:43 -0400
X-MC-Unique: MNWXdEdYP5G7PizNudo_hA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D18B29AA39D;
 Mon, 27 May 2024 10:41:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D231A200A381;
 Mon, 27 May 2024 10:41:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF5E921E6757; Mon, 27 May 2024 12:41:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  fam@euphon.net,  kwolf@redhat.com,
 hreitz@redhat.com,  marcandre.lureau@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  pbonzini@redhat.com,  richard.henderson@linaro.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 4/6] cpus: Improve error messages on memsave, pmemsave
 write error
In-Reply-To: <e84312c2-595c-4edc-bd9d-3954a0521ed2@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 May 2024 16:58:11
 +0200")
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-5-armbru@redhat.com>
 <5ad42c0c-abd0-4fce-8204-9effa4765ab8@linaro.org>
 <87r0e56a8p.fsf@pond.sub.org>
 <e84312c2-595c-4edc-bd9d-3954a0521ed2@linaro.org>
Date: Mon, 27 May 2024 12:41:41 +0200
Message-ID: <871q5nedui.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 13/5/24 16:45, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> On 13/5/24 16:17, Markus Armbruster wrote:
>>>> qmp_memsave() and qmp_pmemsave() report fwrite() error as
>>>>
>>>>       An IO error has occurred
>>>>
>>>> Improve this to
>>>>
>>>>       writing memory to '<filename>' failed
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>    system/cpus.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/system/cpus.c b/system/cpus.c
>>>> index 68d161d96b..f8fa78f33d 100644
>>>> --- a/system/cpus.c
>>>> +++ b/system/cpus.c
>>>> @@ -813,7 +813,8 @@ void qmp_memsave(int64_t addr, int64_t size, const=
 char *filename,
>>>>              goto exit;
>>>>          }
>>>>          if (fwrite(buf, 1, l, f) !=3D l) {
>>>> -            error_setg(errp, QERR_IO_ERROR);
>>>> +            error_setg(errp, "writing memory to '%s' failed",
>>>> +                       filename);
>>>>              goto exit;
>>>>          }
>>>>          addr +=3D l;
>>>> @@ -843,7 +844,8 @@ void qmp_pmemsave(int64_t addr, int64_t size, cons=
t char *filename,
>>>>              l =3D size;
>>>>          cpu_physical_memory_read(addr, buf, l);
>>>>          if (fwrite(buf, 1, l, f) !=3D l) {
>>>> -            error_setg(errp, QERR_IO_ERROR);
>>>> +            error_setg(errp, "writing memory to '%s' failed",
>>>> +                       filename);
>>>
>>> What about including errno with error_setg_errno()?
>>
>> Sure fwrite() fails with errno reliably set?  The manual page doesn't
>> mention it...
>
> Indeed. I can see some uses in the code base:
>
> qemu-io-cmds.c:409:    if (ferror(f)) {
> qemu-io-cmds.c-410-        perror(file_name);

This is after fread(), which isn't specified to set errno, either.

> qga/commands-posix.c-632-    write_count =3D fwrite(buf, 1, count, fh);
> qga/commands-posix.c:633:    if (ferror(fh)) {
> qga/commands-posix.c-634-        error_setg_errno(errp, errno, "failed to=
 write to file");

This one is after fwrite(), like the code I'm changing.

> util/qemu-config.c:152:    if (ferror(fp)) {
> util/qemu-config.c-153-        loc_pop(&loc);
> util/qemu-config.c-154-        error_setg_errno(errp, errno, "Cannot read=
 config file");

This is after fgets(), which isn't specified to set errno, either.

All three uses feel iffy to me.  They work if the stream's error
indicator is clear before fread() / fwrite() / fgets(), and it is set
there, and the reason for it being set is something that sets errno
(such as a failed system call, which seems likely), and errno remains
untouched until after ferror().  Too much "if", "seems likely" for my
taste.

> Regardless,
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!


