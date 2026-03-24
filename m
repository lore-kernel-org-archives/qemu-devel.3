Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B3F54AC0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52Qr-00041V-1f; Tue, 24 Mar 2026 10:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w52Qm-0003xp-Kh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w52Qg-0001ka-34
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774361300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+WLEHqrx9d+2HCZlfa4G6IypWidYd6oJoSwscRvULo=;
 b=U6qjVXFF3mFQEAIBwVt23UzSbLUNSpca9CiYNdA3ATBQWjx7xYy8ndc/U/XHqK/G5L9O5H
 /qklGrzlcgRFCoSMvq/alp0bUpUp3qeiStDPnppY98GTOM/CDKGkIGDj6kP9+awpUlN6aa
 cTO6DUCVEmDE/8NQJ+kIBBaglmywrYs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-7bRPXZenN36e8ruuqeVleQ-1; Tue, 24 Mar 2026 10:08:17 -0400
X-MC-Unique: 7bRPXZenN36e8ruuqeVleQ-1
X-Mimecast-MFC-AGG-ID: 7bRPXZenN36e8ruuqeVleQ_1774361296
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a118530219so2972913e87.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774361296; cv=none;
 d=google.com; s=arc-20240605;
 b=jLzXyxSIK2Py8XshJQ5OoJDSKzrPosGszPXzPstt8JDUJaynlw0WToSYJF94h39nie
 OCWFb8S8GsPa64FBXDelhQPUBZet3jd9xAfLCboSMJTog04qHl7rJwT2bs+caAbhvMkr
 86e9J3DHTXcTHRxQixchpo9Mh9IJqPgG8c1sz4YZHDAuV4+IOQlFLLPFXvC7XwHlUVtE
 qCd7cWuzKVk2MXcYdlVZH+3QerkxfM7onK4jKmUcBfts9yx8ZQhfh8M2bCFh7NPXCbC0
 iwKkawclubfo/J10t3ZcSytIq2zNVxSAOewCeaPDjRusTblPgrUpwg5p6cch3E6jJZv/
 x+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J+WLEHqrx9d+2HCZlfa4G6IypWidYd6oJoSwscRvULo=;
 fh=yKV49/8Aa+UEem2ZeBs0cL+o7pYYUghV0aS1Spa274U=;
 b=dxCw4Nnyq3zhoAqNs79rQPKGaAtMxTroKdiTO7e9SJEAwVmKgXhGDz2qsKQGDeBQdi
 LHTTxBX1Wj+Xl8JNmkXzgfOr1RpO14kiUfySgcKzW96EP1U22aXWBNERfSFDOc4cGKUg
 nshcsawL+B3mrhBDidk1ejoWkJ68dkP5VOfT0rVRsshi9E4fLuECbmxJLktUATwm3/pM
 e6HWJhw/fYpE4f1A8VBqXMwH9Egngt+jL0VSNmP8bOHEjOf1Cnfg4nU6Sg9ekt6/8ZIF
 bL2jsklZSy0rD4JLLfTIgc4VE6xuotQhVogBUUwE4ltZ2EktgwYBeaLR0azoAXLh99aB
 LKRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774361296; x=1774966096; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J+WLEHqrx9d+2HCZlfa4G6IypWidYd6oJoSwscRvULo=;
 b=IMsX3rjX+hno8MTQ2yHaARVTvc24j4YgTTUIhe84+ZTws25Yfpn9hEkC8QZty+NqKj
 Uq8bGeK6GM6VK00eBXxaD5lYNn817soCaOk6MJn5jYAEGHOUrfKthtdv3W9KMXNruOGq
 HPfk07cBdtZ0vT5wkU0dljsw2vZ/B9IVwbReoQ4GU6lh7YoD2LwLyUcnCHdTB5nYSnZ6
 1acYtS7a/PDWbjde6zbGw5N1CiOE9pGqdMFJDEHKRTmNReidAfh4RZ64544NHhsWtOup
 P4t0+EBjE45WJpO2CQBEOvAGoj+ri72QIpi85xYGQUjhHhTaFYLsioFVM8WrTemXWr4C
 JMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361296; x=1774966096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+WLEHqrx9d+2HCZlfa4G6IypWidYd6oJoSwscRvULo=;
 b=M2+n+pZQ0J9t6YmmV3o5MIeQxxlsE1LH4uV+9guccCWJWdrz+tzKL5x3ixcOaSoJfX
 ZFXy48z2QqMOw5zqR1l1ZAIpbCA4m+mTs1HpOipNO0bon7mO9fEjHMFyQzTAWOqr2Osq
 CG1JCzrXhd8PrV5CtKCQ7g1N21Ga6lYR4LIvgVF1TmpKLl/1YuIfnivF3RQJuxz7PZCT
 9N7JFgfCUTPyNcGqBD7Eb6VugwPXeM9byzHhpOHee6v5wILCaNKedJESMsWSrRldtrKO
 63mxHbtevPv8TjARjn+ixS+jeO2SXCOCfHahQgGE4Ip1fhBdGASNjk+G4gGnMM9NyDcq
 1YCg==
X-Gm-Message-State: AOJu0YzZsAm6BnpGa+gygDAWjESzxA8I71hQb8cqSlo9Of4W1o8MEDVm
 aAT3cY2kfcy2HP0MOdi8SA/a4bfqq7sQ7b8Vz1KV8xikLbuke7Eu3LgIyxrLddt5m9oiW/iyLY2
 FEy8Wy09xIRqFEbkyP0IGzkCWeY9c0tVDlJ2qXTtGxkZoupxeNqtbMQ7XHuEkD6ogTJi1dBsTKW
 euwdgBQl7pZIsuEJDOjtQOWEgj+tu7pqI=
X-Gm-Gg: ATEYQzyMrLexxna3HZ7h1wK7i5hefH09GReLt5+NcLkllMLysFIkrOAftPkggJ1TDAl
 Ai1+AZtO0iraFvSkTMh5lZqTg0jBkxaXQngaxAF5v25bTzs1cBDhZUj3M8ojvJICrqyqecwSdP4
 VLJ//cO1QTmCDnNF5jKTK+F3d/iGLWfD4O48HKyNVcHOZ/KQdZs8Ln77GN6xg6FkU7QLIAZbMII
 rIB
X-Received: by 2002:a05:6512:2246:b0:5a1:187d:fefd with SMTP id
 2adb3069b0e04-5a285af8bf2mr4995770e87.11.1774361296155; 
 Tue, 24 Mar 2026 07:08:16 -0700 (PDT)
X-Received: by 2002:a05:6512:2246:b0:5a1:187d:fefd with SMTP id
 2adb3069b0e04-5a285af8bf2mr4995758e87.11.1774361295577; Tue, 24 Mar 2026
 07:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260312141657.1701801-1-eashurov@redhat.com>
 <20260318154752.1880933-1-eashurov@redhat.com>
 <20260318154752.1880933-2-eashurov@redhat.com>
 <CAPMcbCrLQevjUZSMdiSL-ZdMernNzXhGM3NEe8XXgEi-yNx5RQ@mail.gmail.com>
In-Reply-To: <CAPMcbCrLQevjUZSMdiSL-ZdMernNzXhGM3NEe8XXgEi-yNx5RQ@mail.gmail.com>
From: Elizabeth Ashurov <eashurov@redhat.com>
Date: Tue, 24 Mar 2026 16:08:02 +0200
X-Gm-Features: AQROBzDZiZyMPe5mPWr_3Yqrtcy1PxxY9gAIeG1nkTOxpJQEI5OxSAyYjm89VoU
Message-ID: <CAK957kFBi0LOn2SABHna_4ce2c1x0=4QP10mNut4o=r+wt3dXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qga: add --audit option for command logging control
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, yvugenfi@redhat.com
Content-Type: multipart/alternative; boundary="000000000000b9f3a5064dc5ae8d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000b9f3a5064dc5ae8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the review. I'm working on v3 and addressed the comments.

Regarding the g_debug lines in guest_exec: I kept them because ga_audit_log
only logs the command name, while the g_debug lines include the arguments
(str) and the PID. This was previously logged at info level, so I wanted to
avoid losing that information.

Regarding NULL safety of ga_audit_log: the function itself is not
NULL-safe, but the current flow does not call it with NULL.
I will add an explicit check at the beginning of ga_audit_log for safety.

Let me know if you prefer to keep the g_debug lines. Otherwise, I=E2=80=99l=
l remove
them and send v3.

On Mon, Mar 23, 2026 at 3:46=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com>
wrote:

>
>
> On Wed, Mar 18, 2026 at 5:48=E2=80=AFPM Elizabeth Ashurov <eashurov@redha=
t.com>
> wrote:
>
>> Add -A/--audit=3DLIST option to control which guest agent commands
>> are logged at info level (visible with --verbose) and which at
>> debug level (visible only with --debug).
>>
>> Patterns are comma-separated and checked in order; the first match
>> wins. Patterns starting with '!' log the command at debug level
>> instead of info.
>> For example: --audit=3D!guest-ping,* logs all commands
>> at info level except guest-ping.
>>
>> Move command logging from individual handlers into process_event()
>> so all commands are logged in one place. Keep g_debug() calls in
>> handlers for useful details like file paths, handles, and PIDs.
>>
>> The default pattern is '*', so all commands are logged at info
>> level unless configured otherwise.
>>
>> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>> ---
>>  qga/commands-linux.c |  2 --
>>  qga/commands-posix.c | 11 +++----
>>  qga/commands-win32.c | 14 +++------
>>  qga/commands.c       |  6 ++--
>>  qga/main.c           | 73 ++++++++++++++++++++++++++++++++++++++++++--
>>  5 files changed, 81 insertions(+), 25 deletions(-)
>>
>> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>> index a722de2e6a..8df83963fa 100644
>> --- a/qga/commands-linux.c
>> +++ b/qga/commands-linux.c
>> @@ -1158,8 +1158,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum=
,
>> Error **errp)
>>      int fd;
>>      struct fstrim_range r;
>>
>> -    g_info("guest-fstrim called");
>> -
>>      QTAILQ_INIT(&mounts);
>>      if (!build_fs_mount_list(&mounts, errp)) {
>>          return NULL;
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 96939a6f36..6a3e6c78e3 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -240,7 +240,7 @@ void qmp_guest_shutdown(const char *mode, Error
>> **errp)
>>      const char *reboot_flag =3D "-r";
>>  #endif
>>
>> -    g_info("guest-shutdown called, mode: %s", mode);
>> +    g_debug("guest-shutdown mode: %s", mode);
>>      if (!mode || strcmp(mode, "powerdown") =3D=3D 0) {
>>          if (access(POWEROFF_CMD_PATH, X_OK) =3D=3D 0) {
>>              shutdown_cmd =3D POWEROFF_CMD_PATH;
>> @@ -519,7 +519,7 @@ int64_t qmp_guest_file_open(const char *path, const
>> char *mode,
>>      if (!mode) {
>>          mode =3D "r";
>>      }
>> -    g_info("guest-file-open called, filepath: %s, mode: %s", path, mode=
);
>> +    g_debug("guest-file-open filepath: %s, mode: %s", path, mode);
>>      fh =3D safe_open_or_create(path, mode, &local_err);
>>      if (local_err !=3D NULL) {
>>          error_propagate(errp, local_err);
>> @@ -540,7 +540,7 @@ int64_t qmp_guest_file_open(const char *path, const
>> char *mode,
>>          return -1;
>>      }
>>
>> -    g_info("guest-file-open, handle: %" PRId64, handle);
>> +    g_debug("guest-file-open handle: %" PRId64, handle);
>>      return handle;
>>  }
>>
>> @@ -549,7 +549,7 @@ void qmp_guest_file_close(int64_t handle, Error
>> **errp)
>>      GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
>>      int ret;
>>
>> -    g_info("guest-file-close called, handle: %" PRId64, handle);
>> +    g_debug("guest-file-close handle: %" PRId64, handle);
>>      if (!gfh) {
>>          return;
>>      }
>> @@ -793,8 +793,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
>> has_mountpoints,
>>      FsMountList mounts;
>>      Error *local_err =3D NULL;
>>
>> -    g_info("guest-fsfreeze called");
>> -
>>      execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>> @@ -833,7 +831,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>
>>      if (ret >=3D 0) {
>>          ga_unset_frozen(ga_state);
>> -        g_info("guest-fsthaw called");
>>          execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
>>      } else {
>>          ret =3D 0;
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index d26b0041ce..e916d081f5 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -231,7 +231,7 @@ int64_t qmp_guest_file_open(const char *path, const
>> char *mode, Error **errp)
>>      if (!mode) {
>>          mode =3D "r";
>>      }
>> -    g_info("guest-file-open called, filepath: %s, mode: %s", path, mode=
);
>> +    g_debug("guest-file-open filepath: %s, mode: %s", path, mode);
>>      guest_flags =3D find_open_flag(mode);
>>      if (guest_flags =3D=3D NULL) {
>>          error_setg(errp, "invalid file open mode");
>> @@ -267,8 +267,7 @@ int64_t qmp_guest_file_open(const char *path, const
>> char *mode, Error **errp)
>>          goto done;
>>      }
>>
>> -    g_info("guest-file-open, handle: % " PRId64, fd);
>> -
>> +    g_debug("guest-file-open handle: %" PRId64, fd);
>>  done:
>>      g_free(w_path);
>>      return fd;
>> @@ -278,7 +277,7 @@ void qmp_guest_file_close(int64_t handle, Error
>> **errp)
>>  {
>>      bool ret;
>>      GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
>> -    g_info("guest-file-close called, handle: %" PRId64, handle);
>> +    g_debug("guest-file-close handle: %" PRId64, handle);
>>      if (gfh =3D=3D NULL) {
>>          return;
>>      }
>> @@ -337,8 +336,7 @@ void qmp_guest_shutdown(const char *mode, Error
>> **errp)
>>      Error *local_err =3D NULL;
>>      UINT shutdown_flag =3D EWX_FORCE;
>>
>> -    g_info("guest-shutdown called, mode: %s", mode);
>> -
>> +    g_debug("guest-shutdown mode: %s", mode);
>>      if (!mode || strcmp(mode, "powerdown") =3D=3D 0) {
>>          shutdown_flag |=3D EWX_POWEROFF;
>>      } else if (strcmp(mode, "halt") =3D=3D 0) {
>> @@ -1255,8 +1253,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
>> has_mountpoints,
>>          return 0;
>>      }
>>
>> -    g_info("guest-fsfreeze called");
>> -
>>      /* cannot risk guest agent blocking itself on a write in this state
>> */
>>      ga_set_frozen(ga_state);
>>
>> @@ -1294,8 +1290,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>
>>      ga_unset_frozen(ga_state);
>>
>> -    g_info("guest-fsthaw called");
>> -
>>      return i;
>>  }
>>
>> diff --git a/qga/commands.c b/qga/commands.c
>> index 55edd9fd4c..4462922005 100644
>> --- a/qga/commands.c
>> +++ b/qga/commands.c
>> @@ -43,7 +43,6 @@ int64_t qmp_guest_sync(int64_t id, Error **errp)
>>
>>  void qmp_guest_ping(Error **errp)
>>  {
>> -    g_info("guest-ping called");
>>  }
>>
>>  static void qmp_command_info(const QmpCommand *cmd, void *opaque)
>> @@ -136,8 +135,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid,
>> Error **errp)
>>      GuestExecInfo *gei;
>>      GuestExecStatus *ges;
>>
>> -    g_info("guest-exec-status called, pid: %u", (uint32_t)pid);
>> -
>> +    g_debug("guest-exec-status pid: %u", (uint32_t)pid);
>>
>
> any reason for g_debug there? will it be printed by ga_audit_log?
>
> in any case, the extra line was removed
>
>      gei =3D guest_exec_info_find(pid);
>>      if (gei =3D=3D NULL) {
>>          error_setg(errp, "PID " PRId64 " does not exist");
>> @@ -238,7 +236,7 @@ static char **guest_exec_get_args(const strList
>> *entry, bool log)
>>      args[i] =3D NULL;
>>
>>      if (log) {
>> -        g_info("guest-exec called: \"%s\"", str);
>> +        g_debug("guest-exec called: \"%s\"", str);
>>
>
> the same
>
>
>>      }
>>      g_free(str);
>>
>> diff --git a/qga/main.c b/qga/main.c
>> index 04c772b680..5b289ae7f9 100644
>> --- a/qga/main.c
>> +++ b/qga/main.c
>> @@ -87,8 +87,10 @@ struct GAConfig {
>>  #endif
>>      gchar *bliststr; /* blockedrpcs may point to this string */
>>      gchar *aliststr; /* allowedrpcs may point to this string */
>> +    gchar *auditstr;
>>      GList *blockedrpcs;
>>      GList *allowedrpcs;
>> +    GList *audit_patterns;
>>      int daemonize;
>>      GLogLevelFlags log_level;
>>      int dumpconf;
>> @@ -116,6 +118,7 @@ struct GAState {
>>      bool frozen;
>>      GList *blockedrpcs;
>>      GList *allowedrpcs;
>> +    GList *audit_patterns;
>>      char *state_filepath_isfrozen;
>>      struct {
>>          const char *log_filepath;
>> @@ -288,6 +291,11 @@ QEMU_COPYRIGHT "\n"
>>  "                    only, default is %s)\n"
>>  "  -v, --verbose     enable verbose logging (warning/info and above)\n"
>>  "  -g, --debug       enable debug logging (all messages)\n"
>> +"  -A, --audit=3DLIST  comma-separated list of command patterns to log
>> at\n"
>> +"                    info level (default: *, no spaces).\n"
>> +"                    Patterns prefixed with '!' are logged at debug
>> level.\n"
>> +"                    Patterns are evaluated in order; the first match
>> wins.\n"
>> +"                    Example: --audit=3D!guest-ping,*\n"
>>  "  -V, --version     print version information and exit\n"
>>  "  -d, --daemonize   become a daemon\n"
>>  #ifdef _WIN32
>> @@ -413,6 +421,29 @@ static void ga_log(const gchar *domain,
>> GLogLevelFlags level,
>>      }
>>  }
>>
>> +static void ga_audit_log(GAState *s, const char *command)
>> +{
>> +    GList *l;
>> +
>> +    for (l =3D s->audit_patterns; l; l =3D l->next) {
>> +        const char *pattern =3D l->data;
>> +
>> +        if (pattern[0] =3D=3D '!') {
>> +            if (g_pattern_match_simple(pattern + 1, command)) {
>> +                g_debug("%s called", command);
>> +                return;
>> +            }
>> +        } else {
>> +            if (g_pattern_match_simple(pattern, command)) {
>> +                g_info("%s called", command);
>> +                return;
>> +            }
>> +        }
>> +    }
>> +
>> +    g_debug("%s called", command);
>> +}
>> +
>>  void ga_set_response_delimited(GAState *s)
>>  {
>>      s->delimit_response =3D true;
>> @@ -706,7 +737,22 @@ static void process_event(void *opaque, QObject
>> *obj, Error *err)
>>      }
>>
>>      g_debug("processing command");
>> -    rsp =3D qmp_dispatch(&ga_commands, obj, false, NULL);
>> +    {
>> +        QDict *dict =3D qobject_to(QDict, obj);
>> +        const char *command =3D dict ? qdict_get_try_str(dict, "execute=
")
>> : NULL;
>> +        bool logging_before =3D ga_logging_enabled(s);
>>
>
> Please add a comment on why we need this.
> I know about fs-thaw and disabled logging, but for other people, this can
> be unclear
>
>
>> +        bool audit =3D command && qmp_find_command(&ga_commands, comman=
d);
>> +
>> +        if (audit) {
>> +            ga_audit_log(s, command);
>>
> What if command =3D NULL? Is ga_audit_log NULL-safe?
>
>
>> +        }
>> +
>> +        rsp =3D qmp_dispatch(&ga_commands, obj, false, NULL);
>> +
>> +        if (!logging_before && audit) {
>> +            ga_audit_log(s, command);
>> +        }
>> +    }
>>
>>  end:
>>      ret =3D send_response(s, rsp);
>> @@ -1158,6 +1204,14 @@ static void config_load(GAConfig *config, const
>> char *confpath, bool required)
>>          config->retry_path =3D
>>              g_key_file_get_boolean(keyfile, "general", "retry-path",
>> &gerr);
>>      }
>> +    if (g_key_file_has_key(keyfile, "general", "audit", NULL)) {
>> +        config->auditstr =3D
>> +            g_key_file_get_string(keyfile, "general", "audit", &gerr);
>> +        config->audit_patterns =3D g_list_concat(config->audit_patterns=
,
>> +                                               g_list_reverse(
>> +
>>  split_list(config->auditstr,
>> +                                                              ",")));
>> +    }
>>
>>      if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL)) {
>>          config->bliststr =3D
>> @@ -1230,6 +1284,9 @@ static void config_dump(GAConfig *config)
>>                             config->log_level & G_LOG_LEVEL_DEBUG);
>>      g_key_file_set_boolean(keyfile, "general", "retry-path",
>>                             config->retry_path);
>> +    tmp =3D list_join(config->audit_patterns, ',');
>> +    g_key_file_set_string(keyfile, "general", "audit", tmp);
>> +    g_free(tmp);
>>      tmp =3D list_join(config->blockedrpcs, ',');
>>      g_key_file_set_string(keyfile, "general", "block-rpcs", tmp);
>>      g_free(tmp);
>> @@ -1251,7 +1308,7 @@ static void config_dump(GAConfig *config)
>>
>>  static void config_parse(GAConfig *config, int argc, char **argv)
>>  {
>> -    const char *sopt =3D "hVvdgc:m:p:l:f:F::b:a:s:t:Dr";
>> +    const char *sopt =3D "hVvdgc:m:p:l:f:F::b:a:A:s:t:Dr";
>>      int opt_ind =3D 0, ch;
>>      const struct option lopt[] =3D {
>>          { "help", 0, NULL, 'h' },
>> @@ -1270,6 +1327,7 @@ static void config_parse(GAConfig *config, int
>> argc, char **argv)
>>          { "daemonize", 0, NULL, 'd' },
>>          { "block-rpcs", 1, NULL, 'b' },
>>          { "allow-rpcs", 1, NULL, 'a' },
>> +        { "audit", 1, NULL, 'A' },
>>  #ifdef _WIN32
>>          { "service", 1, NULL, 's' },
>>  #endif
>> @@ -1363,6 +1421,10 @@ static void config_parse(GAConfig *config, int
>> argc, char **argv)
>>                                                  split_list(optarg, ",")=
);
>>              break;
>>          }
>> +        case 'A':
>> +            g_list_free_full(config->audit_patterns, g_free);
>> +            config->audit_patterns =3D g_list_reverse(split_list(optarg=
,
>> ","));
>> +            break;
>>  #ifdef _WIN32
>>          case 's':
>>              config->service =3D optarg;
>> @@ -1417,6 +1479,8 @@ static void config_free(GAConfig *config)
>>  #endif
>>      g_list_free_full(config->blockedrpcs, g_free);
>>      g_list_free_full(config->allowedrpcs, g_free);
>> +    g_list_free_full(config->audit_patterns, g_free);
>> +    g_free(config->auditstr);
>>      g_free(config);
>>  }
>>
>> @@ -1460,6 +1524,7 @@ static GAState *initialize_agent(GAConfig *config,
>> int socket_activation)
>>      g_assert(ga_state =3D=3D NULL);
>>
>>      s->log_level =3D config->log_level;
>> +    s->audit_patterns =3D config->audit_patterns;
>>      s->log_file =3D stderr;
>>  #ifdef CONFIG_FSFREEZE
>>      s->fsfreeze_hook =3D config->fsfreeze_hook;
>> @@ -1698,6 +1763,10 @@ int main(int argc, char **argv)
>>      init_dfl_pathnames();
>>      config_parse(config, argc, argv);
>>
>> +    if (config->audit_patterns =3D=3D NULL) {
>> +        config->audit_patterns =3D g_list_append(NULL, g_strdup("*"));
>> +    }
>> +
>>      if (config->pid_filepath =3D=3D NULL) {
>>          config->pid_filepath =3D g_strdup(dfl_pathnames.pidfile);
>>      }
>> --
>> 2.51.0
>>
>>

--000000000000b9f3a5064dc5ae8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Thanks for the review. I&#39;m working on v3 an=
d addressed the comments.<br><br>Regarding the g_debug lines in guest_exec:=
 I kept them because ga_audit_log only logs the command name, while the g_d=
ebug lines include the arguments (str) and the PID. This was previously log=
ged at info level, so I wanted to avoid losing that information.<br><br>Reg=
arding NULL safety of ga_audit_log: the function itself is not NULL-safe, b=
ut the current flow does not call it with NULL.<br>I will add an explicit c=
heck at the beginning of ga_audit_log for safety.<br><br>Let me know if you=
 prefer to keep the g_debug lines. Otherwise, I=E2=80=99ll remove them and =
send v3.<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23, 2026 at 3:46=E2=80=AFPM K=
ostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 18,=
 2026 at 5:48=E2=80=AFPM Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@r=
edhat.com" target=3D"_blank">eashurov@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Add -A/--audit=3DLIST optio=
n to control which guest agent commands<br>
are logged at info level (visible with --verbose) and which at<br>
debug level (visible only with --debug).<br>
<br>
Patterns are comma-separated and checked in order; the first match<br>
wins. Patterns starting with &#39;!&#39; log the command at debug level<br>
instead of info.<br>
For example: --audit=3D!guest-ping,* logs all commands<br>
at info level except guest-ping.<br>
<br>
Move command logging from individual handlers into process_event()<br>
so all commands are logged in one place. Keep g_debug() calls in<br>
handlers for useful details like file paths, handles, and PIDs.<br>
<br>
The default pattern is &#39;*&#39;, so all commands are logged at info<br>
level unless configured otherwise.<br>
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c |=C2=A0 2 --<br>
=C2=A0qga/commands-posix.c | 11 +++----<br>
=C2=A0qga/commands-win32.c | 14 +++------<br>
=C2=A0qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++--<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 73 +++++++++++++=
+++++++++++++++++++++++++++++--<br>
=C2=A05 files changed, 81 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index a722de2e6a..8df83963fa 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -1158,8 +1158,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, E=
rror **errp)<br>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
=C2=A0 =C2=A0 =C2=A0struct fstrim_range r;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fstrim called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;mounts);<br>
=C2=A0 =C2=A0 =C2=A0if (!build_fs_mount_list(&amp;mounts, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 96939a6f36..6a3e6c78e3 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -240,7 +240,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0const char *reboot_flag =3D &quot;-r&quot;;<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-shutdown called, mode: %s&quot;, mode);<b=
r>
+=C2=A0 =C2=A0 g_debug(&quot;guest-shutdown mode: %s&quot;, mode);<br>
=C2=A0 =C2=A0 =C2=A0if (!mode || strcmp(mode, &quot;powerdown&quot;) =3D=3D=
 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(POWEROFF_CMD_PATH, X_OK) =3D=
=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_cmd =3D POWEROFF_C=
MD_PATH;<br>
@@ -519,7 +519,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode,<br>
=C2=A0 =C2=A0 =C2=A0if (!mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D &quot;r&quot;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open called, filepath: %s, mode: %s&=
quot;, path, mode);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open filepath: %s, mode: %s&quot;, =
path, mode);<br>
=C2=A0 =C2=A0 =C2=A0fh =3D safe_open_or_create(path, mode, &amp;local_err);=
<br>
=C2=A0 =C2=A0 =C2=A0if (local_err !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
@@ -540,7 +540,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open, handle: %&quot; PRId64, handle=
);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open handle: %&quot; PRId64, handle=
);<br>
=C2=A0 =C2=A0 =C2=A0return handle;<br>
=C2=A0}<br>
<br>
@@ -549,7 +549,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0GuestFileHandle *gfh =3D guest_file_handle_find(handle,=
 errp);<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-close called, handle: %&quot; PRId64=
, handle);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-close handle: %&quot; PRId64, handl=
e);<br>
=C2=A0 =C2=A0 =C2=A0if (!gfh) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -793,8 +793,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpo=
ints,<br>
=C2=A0 =C2=A0 =C2=A0FsMountList mounts;<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fsfreeze called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, &amp;local_=
err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
@@ -833,7 +831,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_info(&quot;guest-fsthaw called&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0execute_fsfreeze_hook(FSFREEZE_HOOK_THAW,=
 errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index d26b0041ce..e916d081f5 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -231,7 +231,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0if (!mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D &quot;r&quot;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open called, filepath: %s, mode: %s&=
quot;, path, mode);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open filepath: %s, mode: %s&quot;, =
path, mode);<br>
=C2=A0 =C2=A0 =C2=A0guest_flags =3D find_open_flag(mode);<br>
=C2=A0 =C2=A0 =C2=A0if (guest_flags =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;invalid file open =
mode&quot;);<br>
@@ -267,8 +267,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open, handle: % &quot; PRId64, fd);<=
br>
-<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open handle: %&quot; PRId64, fd);<b=
r>
=C2=A0done:<br>
=C2=A0 =C2=A0 =C2=A0g_free(w_path);<br>
=C2=A0 =C2=A0 =C2=A0return fd;<br>
@@ -278,7 +277,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool ret;<br>
=C2=A0 =C2=A0 =C2=A0GuestFileHandle *gfh =3D guest_file_handle_find(handle,=
 errp);<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-close called, handle: %&quot; PRId64=
, handle);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-close handle: %&quot; PRId64, handl=
e);<br>
=C2=A0 =C2=A0 =C2=A0if (gfh =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -337,8 +336,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0UINT shutdown_flag =3D EWX_FORCE;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-shutdown called, mode: %s&quot;, mode);<b=
r>
-<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-shutdown mode: %s&quot;, mode);<br>
=C2=A0 =C2=A0 =C2=A0if (!mode || strcmp(mode, &quot;powerdown&quot;) =3D=3D=
 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_flag |=3D EWX_POWEROFF;<br>
=C2=A0 =C2=A0 =C2=A0} else if (strcmp(mode, &quot;halt&quot;) =3D=3D 0) {<b=
r>
@@ -1255,8 +1253,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mount=
points,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fsfreeze called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* cannot risk guest agent blocking itself on a write i=
n this state */<br>
=C2=A0 =C2=A0 =C2=A0ga_set_frozen(ga_state);<br>
<br>
@@ -1294,8 +1290,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fsthaw called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return i;<br>
=C2=A0}<br>
<br>
diff --git a/qga/commands.c b/qga/commands.c<br>
index 55edd9fd4c..4462922005 100644<br>
--- a/qga/commands.c<br>
+++ b/qga/commands.c<br>
@@ -43,7 +43,6 @@ int64_t qmp_guest_sync(int64_t id, Error **errp)<br>
<br>
=C2=A0void qmp_guest_ping(Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-ping called&quot;);<br>
=C2=A0}<br>
<br>
=C2=A0static void qmp_command_info(const QmpCommand *cmd, void *opaque)<br>
@@ -136,8 +135,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0GuestExecInfo *gei;<br>
=C2=A0 =C2=A0 =C2=A0GuestExecStatus *ges;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-exec-status called, pid: %u&quot;, (uint3=
2_t)pid);<br>
-<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-exec-status pid: %u&quot;, (uint32_t)pid=
);<br></blockquote><div><br></div><div>any reason for=C2=A0g_debug there? w=
ill it be printed by=C2=A0ga_audit_log?=C2=A0</div><div><br></div><div>in a=
ny case, the extra line was removed</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0gei =3D guest_exec_info_find(pid);<br>
=C2=A0 =C2=A0 =C2=A0if (gei =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;PID &quot; PRId64 =
&quot; does not exist&quot;);<br>
@@ -238,7 +236,7 @@ static char **guest_exec_get_args(const strList *entry,=
 bool log)<br>
=C2=A0 =C2=A0 =C2=A0args[i] =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (log) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_info(&quot;guest-exec called: \&quot;%s\&quo=
t;&quot;, str);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;guest-exec called: \&quot;%s\&qu=
ot;&quot;, str);<br></blockquote><div><br></div><div>the same</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_free(str);<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 04c772b680..5b289ae7f9 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -87,8 +87,10 @@ struct GAConfig {<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0gchar *bliststr; /* blockedrpcs may point to this strin=
g */<br>
=C2=A0 =C2=A0 =C2=A0gchar *aliststr; /* allowedrpcs may point to this strin=
g */<br>
+=C2=A0 =C2=A0 gchar *auditstr;<br>
=C2=A0 =C2=A0 =C2=A0GList *blockedrpcs;<br>
=C2=A0 =C2=A0 =C2=A0GList *allowedrpcs;<br>
+=C2=A0 =C2=A0 GList *audit_patterns;<br>
=C2=A0 =C2=A0 =C2=A0int daemonize;<br>
=C2=A0 =C2=A0 =C2=A0GLogLevelFlags log_level;<br>
=C2=A0 =C2=A0 =C2=A0int dumpconf;<br>
@@ -116,6 +118,7 @@ struct GAState {<br>
=C2=A0 =C2=A0 =C2=A0bool frozen;<br>
=C2=A0 =C2=A0 =C2=A0GList *blockedrpcs;<br>
=C2=A0 =C2=A0 =C2=A0GList *allowedrpcs;<br>
+=C2=A0 =C2=A0 GList *audit_patterns;<br>
=C2=A0 =C2=A0 =C2=A0char *state_filepath_isfrozen;<br>
=C2=A0 =C2=A0 =C2=A0struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *log_filepath;<br>
@@ -288,6 +291,11 @@ QEMU_COPYRIGHT &quot;\n&quot;<br>
=C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 only, default is %s)\n&quot;<br>
=C2=A0&quot;=C2=A0 -v, --verbose=C2=A0 =C2=A0 =C2=A0enable verbose logging =
(warning/info and above)\n&quot;<br>
=C2=A0&quot;=C2=A0 -g, --debug=C2=A0 =C2=A0 =C2=A0 =C2=A0enable debug loggi=
ng (all messages)\n&quot;<br>
+&quot;=C2=A0 -A, --audit=3DLIST=C2=A0 comma-separated list of command patt=
erns to log at\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 info level (default: *, no spaces).\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Patterns prefixed with &#39;!&#39; are logged at debug level.\n&quot;<b=
r>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Patterns are evaluated in order; the first match wins.\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Example: --audit=3D!guest-ping,*\n&quot;<br>
=C2=A0&quot;=C2=A0 -V, --version=C2=A0 =C2=A0 =C2=A0print version informati=
on and exit\n&quot;<br>
=C2=A0&quot;=C2=A0 -d, --daemonize=C2=A0 =C2=A0become a daemon\n&quot;<br>
=C2=A0#ifdef _WIN32<br>
@@ -413,6 +421,29 @@ static void ga_log(const gchar *domain, GLogLevelFlags=
 level,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void ga_audit_log(GAState *s, const char *command)<br>
+{<br>
+=C2=A0 =C2=A0 GList *l;<br>
+<br>
+=C2=A0 =C2=A0 for (l =3D s-&gt;audit_patterns; l; l =3D l-&gt;next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *pattern =3D l-&gt;data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pattern[0] =3D=3D &#39;!&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_pattern_match_simple(patte=
rn + 1, command)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;%s c=
alled&quot;, command);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_pattern_match_simple(patte=
rn, command)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_info(&quot;%s ca=
lled&quot;, command);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;%s called&quot;, command);<br>
+}<br>
+<br>
=C2=A0void ga_set_response_delimited(GAState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;delimit_response =3D true;<br>
@@ -706,7 +737,22 @@ static void process_event(void *opaque, QObject *obj, =
Error *err)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_debug(&quot;processing command&quot;);<br>
-=C2=A0 =C2=A0 rsp =3D qmp_dispatch(&amp;ga_commands, obj, false, NULL);<br=
>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QDict *dict =3D qobject_to(QDict, obj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *command =3D dict ? qdict_get_try_s=
tr(dict, &quot;execute&quot;) : NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool logging_before =3D ga_logging_enabled(s);=
<br></blockquote><div><br></div><div>Please add a comment on why we need th=
is.</div><div>I know about fs-thaw and disabled logging, but for other peop=
le, this can be unclear=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool audit =3D command &amp;&amp; qmp_find_com=
mand(&amp;ga_commands, command);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (audit) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_audit_log(s, command);<br></b=
lockquote><div>What if command =3D NULL? Is ga_audit_log NULL-safe?=C2=A0</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp =3D qmp_dispatch(&amp;ga_commands, obj, fa=
lse, NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!logging_before &amp;&amp; audit) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_audit_log(s, command);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0end:<br>
=C2=A0 =C2=A0 =C2=A0ret =3D send_response(s, rsp);<br>
@@ -1158,6 +1204,14 @@ static void config_load(GAConfig *config, const char=
 *confpath, bool required)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;retry_path =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_key_file_get_boolean(keyf=
ile, &quot;general&quot;, &quot;retry-path&quot;, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, &quot;a=
udit&quot;, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;auditstr =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_get_string(keyfile, &=
quot;general&quot;, &quot;audit&quot;, &amp;gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;audit_patterns =3D g_list_concat(co=
nfig-&gt;audit_patterns,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0g_list_reverse(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0split_list(config-&gt;auditstr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;,&quot;)));<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (g_key_file_has_key(keyfile, &quot;general&quot;, &q=
uot;block-rpcs&quot;, NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;bliststr =3D<br>
@@ -1230,6 +1284,9 @@ static void config_dump(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;log_level &amp; G_LOG_LEVEL_DEBUG);<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_set_boolean(keyfile, &quot;general&quot;, &q=
uot;retry-path&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;retry_path);<br>
+=C2=A0 =C2=A0 tmp =3D list_join(config-&gt;audit_patterns, &#39;,&#39;);<b=
r>
+=C2=A0 =C2=A0 g_key_file_set_string(keyfile, &quot;general&quot;, &quot;au=
dit&quot;, tmp);<br>
+=C2=A0 =C2=A0 g_free(tmp);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D list_join(config-&gt;blockedrpcs, &#39;,&#39;);=
<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_set_string(keyfile, &quot;general&quot;, &qu=
ot;block-rpcs&quot;, tmp);<br>
=C2=A0 =C2=A0 =C2=A0g_free(tmp);<br>
@@ -1251,7 +1308,7 @@ static void config_dump(GAConfig *config)<br>
<br>
=C2=A0static void config_parse(GAConfig *config, int argc, char **argv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdgc:m:p:l:f:F::b:a:s:t:Dr&quot=
;;<br>
+=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdgc:m:p:l:f:F::b:a:A:s:t:Dr&qu=
ot;;<br>
=C2=A0 =C2=A0 =C2=A0int opt_ind =3D 0, ch;<br>
=C2=A0 =C2=A0 =C2=A0const struct option lopt[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;help&quot;, 0, NULL, &#39;h&#39; =
},<br>
@@ -1270,6 +1327,7 @@ static void config_parse(GAConfig *config, int argc, =
char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;daemonize&quot;, 0, NULL, &#39;d&=
#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;block-rpcs&quot;, 1, NULL, &#39;b=
&#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;allow-rpcs&quot;, 1, NULL, &#39;a=
&#39; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;audit&quot;, 1, NULL, &#39;A&#39; },<b=
r>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;service&quot;, 1, NULL, &#39;s&#3=
9; },<br>
=C2=A0#endif<br>
@@ -1363,6 +1421,10 @@ static void config_parse(GAConfig *config, int argc,=
 char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0split_list(optarg, &quot;,&quot;));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;A&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_list_free_full(config-&gt;audi=
t_patterns, g_free);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;audit_patterns =3D g_=
list_reverse(split_list(optarg, &quot;,&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;s&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;service =3D opta=
rg;<br>
@@ -1417,6 +1479,8 @@ static void config_free(GAConfig *config)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0g_list_free_full(config-&gt;blockedrpcs, g_free);<br>
=C2=A0 =C2=A0 =C2=A0g_list_free_full(config-&gt;allowedrpcs, g_free);<br>
+=C2=A0 =C2=A0 g_list_free_full(config-&gt;audit_patterns, g_free);<br>
+=C2=A0 =C2=A0 g_free(config-&gt;auditstr);<br>
=C2=A0 =C2=A0 =C2=A0g_free(config);<br>
=C2=A0}<br>
<br>
@@ -1460,6 +1524,7 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0g_assert(ga_state =3D=3D NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;log_level =3D config-&gt;log_level;<br>
+=C2=A0 =C2=A0 s-&gt;audit_patterns =3D config-&gt;audit_patterns;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;log_file =3D stderr;<br>
=C2=A0#ifdef CONFIG_FSFREEZE<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;fsfreeze_hook =3D config-&gt;fsfreeze_hook;<br>
@@ -1698,6 +1763,10 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0init_dfl_pathnames();<br>
=C2=A0 =C2=A0 =C2=A0config_parse(config, argc, argv);<br>
<br>
+=C2=A0 =C2=A0 if (config-&gt;audit_patterns =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;audit_patterns =3D g_list_append(NU=
LL, g_strdup(&quot;*&quot;));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (config-&gt;pid_filepath =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;pid_filepath =3D g_strdup(dfl_=
pathnames.pidfile);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>
</div>
</blockquote></div>

--000000000000b9f3a5064dc5ae8d--


