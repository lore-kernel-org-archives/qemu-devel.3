Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F1C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1so-0005bh-8S; Mon, 04 Mar 2024 01:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sa-0005Yw-Nb
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sS-0000A2-OM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLlsNUKUtVhfU2Q7o2WN82R+wfW9DYiKnsyqY8ZASrY=;
 b=hY2b0KrhTMBvmKP3tJ3ITggQpL4wCUXsC+eVq+6TpP34lBhKapiCMgmqbJhtegSXPZgJBY
 gHY2MFk88F4V7EVwrtgBfODTwpoCqn12KZtrvs/zzd1+iKTG3TkcCc76gZbFhwiBauHq+M
 0jtmS3ia4+J/778J9ddhLKNFc9QZwi4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-jquXoRyXPbijFKxcWR45Jw-1; Mon,
 04 Mar 2024 01:32:39 -0500
X-MC-Unique: jquXoRyXPbijFKxcWR45Jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A66EB3816441;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48996C04325;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91C4221E682C; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 14/18] docs/devel/writing-monitor-commands: Repair a decade of
 rot
Date: Mon,  4 Mar 2024 07:32:32 +0100
Message-ID: <20240304063236.213955-15-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

The tutorial doesn't match reality since at least 2013.  Repairing it
involves fixing the following issues:

* Update for commit 6d327171551 (aio / timers: Remove alarm timers):
  replace the broken examples.  Instead of having one for returning a
  struct and another for returning a list of structs, do just one for
  the latter.  This resolves the FIXME added in commit
  e218052f928 (aio / timers: De-document -clock) back in 2014.

* Update for commit 895a2a80e0e (qapi: Use 'struct' instead of 'type'
  in schema).

* Update for commit 3313b6124b5 (qapi: add qapi2texi script): add
  required documentation to the schema snippets, and drop section
  "Command Documentation".

* Update for commit a3c45b3e629 (qapi: New special feature flag
  "unstable"): supply the required feature, deemphasize the x- prefix.

* Update for commit dd98234c059 (qapi: introduce x-query-roms QMP
  command): rephrase from "add new command" to "examine existing
  command".

* Update for commit 9492718b7c0 (qapi misc: Elide redundant has_FOO in
  generated C): hello-world's message argument no longer comes with a
  has_message, add a second argument that does.

* Update for moved and renamed files.

While there, update QMP version output to current output.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227115617.237875-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Whitespace tidied up, typo fixed]
---
 docs/devel/writing-monitor-commands.rst | 466 ++++++++++--------------
 1 file changed, 184 insertions(+), 282 deletions(-)

diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
index b6ee4fa063..cd57f46082 100644
--- a/docs/devel/writing-monitor-commands.rst
+++ b/docs/devel/writing-monitor-commands.rst
@@ -66,12 +66,13 @@ Then, in a different terminal::
          "version": {
              "qemu": {
                  "micro": 50,
-                 "minor": 15,
-                 "major": 0
+                 "minor": 2,
+                 "major": 8
              },
-             "package": ""
+             "package": ...
          },
          "capabilities": [
+             "oob"
          ]
      }
  }
@@ -107,6 +108,11 @@ The first step is defining the command in the appropriate QAPI schema
 module.  We pick module qapi/misc.json, and add the following line at
 the bottom::
 
+ ##
+ # @hello-world:
+ #
+ # Since: 9.0
+ ##
  { 'command': 'hello-world' }
 
 The "command" keyword defines a new QMP command. It's an JSON object. All
@@ -148,37 +154,50 @@ you don't see it then something went wrong.
 Arguments
 ~~~~~~~~~
 
-Let's add an argument called "message" to our "hello-world" command. The new
-argument will contain the string to be printed to stdout. It's an optional
-argument, if it's not present we print our default "Hello, World" string.
+Let's add arguments to our "hello-world" command.
 
 The first change we have to do is to modify the command specification in the
 schema file to the following::
 
- { 'command': 'hello-world', 'data': { '*message': 'str' } }
+ ##
+ # @hello-world:
+ #
+ # @message: message to be printed (default: "Hello, world!")
+ #
+ # @times: how many times to print the message (default: 1)
+ #
+ # Since: 9.0
+ ##
+ { 'command': 'hello-world',
+   'data': { '*message': 'str', '*times': 'int' } }
 
-Notice the new 'data' member in the schema. It's an JSON object whose each
-element is an argument to the command in question. Also notice the asterisk,
-it's used to mark the argument optional (that means that you shouldn't use it
-for mandatory arguments). Finally, 'str' is the argument's type, which
-stands for "string". The QAPI also supports integers, booleans, enumerations
-and user defined types.
+Notice the new 'data' member in the schema. It specifies an argument
+'message' of QAPI type 'str', and an argument 'times' of QAPI type
+'int'.  Also notice the asterisk, it's used to mark the argument
+optional.
 
 Now, let's update our C implementation in monitor/qmp-cmds.c::
 
- void qmp_hello_world(const char *message, Error **errp)
+ void qmp_hello_world(const char *message, bool has_times, int64_t times,
+                      Error **errp)
  {
-     if (message) {
+     if (!message) {
+         message = "Hello, world";
+     }
+     if (!has_times) {
+         times = 1;
+     }
+
+     for (int i = 0; i < times; i++) {
          printf("%s\n", message);
-     } else {
-         printf("Hello, world\n");
      }
  }
 
 There are two important details to be noticed:
 
-1. All optional arguments are accompanied by a 'has\_' boolean, which is set
-   if the optional argument is present or false otherwise
+1. Optional arguments other than pointers are accompanied by a 'has\_'
+   boolean, which is set if the optional argument is present or false
+   otherwise
 2. The C implementation signature must follow the schema's argument ordering,
    which is defined by the "data" member
 
@@ -254,35 +273,6 @@ If the failure you want to report falls into one of the two cases above,
 use error_set() with a second argument of an ErrorClass value.
 
 
-Command Documentation
-~~~~~~~~~~~~~~~~~~~~~
-
-There's only one step missing to make "hello-world"'s implementation complete,
-and that's its documentation in the schema file.
-
-There are many examples of such documentation in the schema file already, but
-here goes "hello-world"'s new entry for qapi/misc.json::
-
- ##
- # @hello-world:
- #
- # Print a client provided string to the standard output stream.
- #
- # @message: string to be printed
- #
- # Returns: Nothing on success.
- #
- # Notes: if @message is not provided, the "Hello, world" string will
- #        be printed instead
- #
- # Since: <next qemu stable release, eg. 1.0>
- ##
- { 'command': 'hello-world', 'data': { '*message': 'str' } }
-
-Please, note that the "Returns" clause is optional if a command doesn't return
-any data nor any errors.
-
-
 Implementing the HMP command
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -306,18 +296,20 @@ Here's the implementation of the "hello-world" HMP command::
      }
  }
 
-Also, you have to add the function's prototype to the hmp.h file.
+Add it to monitor/hmp-cmds.c.  Also, add its prototype to
+include/monitor/hmp.h.
 
-There are three important points to be noticed:
+There are four important points to be noticed:
 
 1. The "mon" and "qdict" arguments are mandatory for all HMP functions. The
    former is the monitor object. The latter is how the monitor passes
    arguments entered by the user to the command implementation
-2. hmp_hello_world() performs error checking. In this example we just call
+2. We chose not to support the "times" argument in HMP
+3. hmp_hello_world() performs error checking. In this example we just call
    hmp_handle_error() which prints a message to the user, but we could do
    more, like taking different actions depending on the error
    qmp_hello_world() returns
-3. The "err" variable must be initialized to NULL before performing the
+4. The "err" variable must be initialized to NULL before performing the
    QMP call
 
 There's one last step to actually make the command available to monitor users,
@@ -372,7 +364,7 @@ data, it is not expected that machines will need to parse the result.
 The overhead of defining a fine grained QAPI type for the data may not
 be justified by the potential benefit. In such cases, it is permitted
 to have a command return a simple string that contains formatted data,
-however, it is mandatory for the command to use the 'x-' name prefix.
+however, it is mandatory for the command to be marked unstable.
 This indicates that the command is not guaranteed to be long term
 stable / liable to change in future and is not following QAPI design
 best practices. An example where this approach is taken is the QMP
@@ -386,302 +378,207 @@ an illustration.
 User Defined Types
 ~~~~~~~~~~~~~~~~~~
 
-FIXME This example needs to be redone after commit 6d32717
+For this example we will write the query-option-roms command, which
+returns information about ROMs loaded into the option ROM space. For
+more information about it, please check the "-option-rom" command-line
+option.
 
-For this example we will write the query-alarm-clock command, which returns
-information about QEMU's timer alarm. For more information about it, please
-check the "-clock" command-line option.
-
-We want to return two pieces of information. The first one is the alarm clock's
-name. The second one is when the next alarm will fire. The former information is
-returned as a string, the latter is an integer in nanoseconds (which is not
-very useful in practice, as the timer has probably already fired when the
-information reaches the client).
-
-The best way to return that data is to create a new QAPI type, as shown below::
+For each option ROM, we want to return two pieces of information: the
+ROM image's file name, and its bootindex, if any.  We need to create a
+new QAPI type for that, as shown below::
 
  ##
- # @QemuAlarmClock
+ # @OptionRomInfo:
  #
- # QEMU alarm clock information.
+ # @filename: option ROM image file name
  #
- # @clock-name: The alarm clock method's name.
+ # @bootindex: option ROM's bootindex
  #
- # @next-deadline: The time (in nanoseconds) the next alarm will fire.
- #
- # Since: 1.0
+ # Since: 9.0
  ##
- { 'type': 'QemuAlarmClock',
-   'data': { 'clock-name': 'str', '*next-deadline': 'int' } }
+ { 'struct': 'OptionRomInfo',
+   'data': { 'filename': 'str', '*bootindex': 'int' } }
 
-The "type" keyword defines a new QAPI type. Its "data" member contains the
-type's members. In this example our members are the "clock-name" and the
-"next-deadline" one, which is optional.
+The "struct" keyword defines a new QAPI type. Its "data" member
+contains the type's members. In this example our members are
+"filename" and "bootindex". The latter is optional.
 
-Now let's define the query-alarm-clock command::
+Now let's define the query-option-roms command::
 
  ##
- # @query-alarm-clock
+ # @query-option-roms:
  #
- # Return information about QEMU's alarm clock.
+ # Query information on ROMs loaded into the option ROM space.
  #
- # Returns a @QemuAlarmClock instance describing the alarm clock method
- # being currently used by QEMU (this is usually set by the '-clock'
- # command-line option).
+ # Returns: OptionRomInfo
  #
- # Since: 1.0
+ # Since: 9.0
  ##
- { 'command': 'query-alarm-clock', 'returns': 'QemuAlarmClock' }
+ { 'command': 'query-option-roms',
+   'returns': ['OptionRomInfo'] }
 
 Notice the "returns" keyword. As its name suggests, it's used to define the
 data returned by a command.
 
-It's time to implement the qmp_query_alarm_clock() function, you can put it
-in the qemu-timer.c file::
+Notice the syntax ['OptionRomInfo']". This should be read as "returns
+a list of OptionRomInfo".
 
- QemuAlarmClock *qmp_query_alarm_clock(Error **errp)
+It's time to implement the qmp_query_option_roms() function.  Add to
+monitor/qmp-cmds.c::
+
+ OptionRomInfoList *qmp_query_option_roms(Error **errp)
  {
-     QemuAlarmClock *clock;
-     int64_t deadline;
+     OptionRomInfoList *info_list = NULL;
+     OptionRomInfoList **tailp = &info_list;
+     OptionRomInfo *info;
 
-     clock = g_malloc0(sizeof(*clock));
-
-     deadline = qemu_next_alarm_deadline();
-     if (deadline > 0) {
-         clock->has_next_deadline = true;
-         clock->next_deadline = deadline;
+     for (int i = 0; i < nb_option_roms; i++) {
+         info = g_malloc0(sizeof(*info));
+         info->filename = g_strdup(option_rom[i].name);
+         info->has_bootindex = option_rom[i].bootindex >= 0;
+         if (info->has_bootindex) {
+             info->bootindex = option_rom[i].bootindex;
+         }
+         QAPI_LIST_APPEND(tailp, info);
      }
-     clock->clock_name = g_strdup(alarm_timer->name);
 
-     return clock;
+     return info_list;
  }
 
 There are a number of things to be noticed:
 
-1. The QemuAlarmClock type is automatically generated by the QAPI framework,
-   its members correspond to the type's specification in the schema file
-2. As specified in the schema file, the function returns a QemuAlarmClock
-   instance and takes no arguments (besides the "errp" one, which is mandatory
-   for all QMP functions)
-3. The "clock" variable (which will point to our QAPI type instance) is
-   allocated by the regular g_malloc0() function. Note that we chose to
-   initialize the memory to zero. This is recommended for all QAPI types, as
-   it helps avoiding bad surprises (specially with booleans)
-4. Remember that "next_deadline" is optional? Non-pointer optional
-   members have a 'has_TYPE_NAME' member that should be properly set
+1. Type OptionRomInfo is automatically generated by the QAPI framework,
+   its members correspond to the type's specification in the schema
+   file
+2. Type OptionRomInfoList is also generated.  It's a singly linked
+   list.
+3. As specified in the schema file, the function returns a
+   OptionRomInfoList, and takes no arguments (besides the "errp" one,
+   which is mandatory for all QMP functions)
+4. The returned object is dynamically allocated
+5. All strings are dynamically allocated. This is so because QAPI also
+   generates a function to free its types and it cannot distinguish
+   between dynamically or statically allocated strings
+6. Remember that "bootindex" is optional? As a non-pointer optional
+   member, it comes with a 'has_bootindex' member that needs to be set
    by the implementation, as shown above
-5. Even static strings, such as "alarm_timer->name", should be dynamically
-   allocated by the implementation. This is so because the QAPI also generates
-   a function to free its types and it cannot distinguish between dynamically
-   or statically allocated strings
-6. You have to include "qapi/qapi-commands-misc.h" in qemu-timer.c
 
 Time to test the new command. Build qemu, run it as described in the "Testing"
 section and try this::
 
- { "execute": "query-alarm-clock" }
+ { "execute": "query-option-rom" }
  {
-     "return": {
-         "next-deadline": 2368219,
-         "clock-name": "dynticks"
-     }
+     "return": [
+         {
+             "filename": "kvmvapic.bin"
+         }
+     ]
  }
 
 
 The HMP command
 ~~~~~~~~~~~~~~~
 
-Here's the HMP counterpart of the query-alarm-clock command::
+Here's the HMP counterpart of the query-option-roms command::
 
- void hmp_info_alarm_clock(Monitor *mon)
+ void hmp_info_option_roms(Monitor *mon, const QDict *qdict)
  {
-     QemuAlarmClock *clock;
      Error *err = NULL;
+     OptionRomInfoList *info_list, *tail;
+     OptionRomInfo *info;
 
-     clock = qmp_query_alarm_clock(&err);
+     info_list = qmp_query_option_roms(&err);
      if (hmp_handle_error(mon, err)) {
          return;
      }
 
-     monitor_printf(mon, "Alarm clock method in use: '%s'\n", clock->clock_name);
-     if (clock->has_next_deadline) {
-         monitor_printf(mon, "Next alarm will fire in %" PRId64 " nanoseconds\n",
-                        clock->next_deadline);
-     }
-
-    qapi_free_QemuAlarmClock(clock);
- }
-
-It's important to notice that hmp_info_alarm_clock() calls
-qapi_free_QemuAlarmClock() to free the data returned by qmp_query_alarm_clock().
-For user defined types, the QAPI will generate a qapi_free_QAPI_TYPE_NAME()
-function and that's what you have to use to free the types you define and
-qapi_free_QAPI_TYPE_NAMEList() for list types (explained in the next section).
-If the QMP call returns a string, then you should g_free() to free it.
-
-Also note that hmp_info_alarm_clock() performs error handling. That's not
-strictly required if you're sure the QMP function doesn't return errors, but
-it's good practice to always check for errors.
-
-Another important detail is that HMP's "info" commands don't go into the
-hmp-commands.hx. Instead, they go into the info_cmds[] table, which is defined
-in the monitor/misc.c file. The entry for the "info alarmclock" follows::
-
-    {
-        .name       = "alarmclock",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show information about the alarm clock",
-        .cmd        = hmp_info_alarm_clock,
-    },
-
-To test this, run qemu and type "info alarmclock" in the user monitor.
-
-
-Returning Lists
-~~~~~~~~~~~~~~~
-
-For this example, we're going to return all available methods for the timer
-alarm, which is pretty much what the command-line option "-clock ?" does,
-except that we're also going to inform which method is in use.
-
-This first step is to define a new type::
-
- ##
- # @TimerAlarmMethod
- #
- # Timer alarm method information.
- #
- # @method-name: The method's name.
- #
- # @current: true if this alarm method is currently in use, false otherwise
- #
- # Since: 1.0
- ##
- { 'type': 'TimerAlarmMethod',
-   'data': { 'method-name': 'str', 'current': 'bool' } }
-
-The command will be called "query-alarm-methods", here is its schema
-specification::
-
- ##
- # @query-alarm-methods
- #
- # Returns information about available alarm methods.
- #
- # Returns: a list of @TimerAlarmMethod for each method
- #
- # Since: 1.0
- ##
- { 'command': 'query-alarm-methods', 'returns': ['TimerAlarmMethod'] }
-
-Notice the syntax for returning lists "'returns': ['TimerAlarmMethod']", this
-should be read as "returns a list of TimerAlarmMethod instances".
-
-The C implementation follows::
-
- TimerAlarmMethodList *qmp_query_alarm_methods(Error **errp)
- {
-     TimerAlarmMethodList *method_list = NULL;
-     const struct qemu_alarm_timer *p;
-     bool current = true;
-
-     for (p = alarm_timers; p->name; p++) {
-         TimerAlarmMethod *value = g_malloc0(*value);
-         value->method_name = g_strdup(p->name);
-         value->current = current;
-         QAPI_LIST_PREPEND(method_list, value);
-         current = false;
-     }
-
-     return method_list;
- }
-
-The most important difference from the previous examples is the
-TimerAlarmMethodList type, which is automatically generated by the QAPI from
-the TimerAlarmMethod type.
-
-Each list node is represented by a TimerAlarmMethodList instance. We have to
-allocate it, and that's done inside the for loop: the "info" pointer points to
-an allocated node. We also have to allocate the node's contents, which is
-stored in its "value" member. In our example, the "value" member is a pointer
-to an TimerAlarmMethod instance.
-
-Notice that the "current" variable is used as "true" only in the first
-iteration of the loop. That's because the alarm timer method in use is the
-first element of the alarm_timers array. Also notice that QAPI lists are handled
-by hand and we return the head of the list.
-
-Now Build qemu, run it as explained in the "Testing" section and try our new
-command::
-
- { "execute": "query-alarm-methods" }
- {
-     "return": [
-         {
-             "current": false,
-             "method-name": "unix"
-         },
-         {
-             "current": true,
-             "method-name": "dynticks"
+     for (tail = info_list; tail; tail = tail->next) {
+         info = tail->value;
+         monitor_printf(mon, "%s", info->filename);
+         if (info->has_bootindex) {
+             monitor_printf(mon, " %" PRId64, info->bootindex);
          }
-     ]
- }
-
-The HMP counterpart is a bit more complex than previous examples because it
-has to traverse the list, it's shown below for reference::
-
- void hmp_info_alarm_methods(Monitor *mon)
- {
-     TimerAlarmMethodList *method_list, *method;
-     Error *err = NULL;
-
-     method_list = qmp_query_alarm_methods(&err);
-     if (hmp_handle_error(mon, err)) {
-         return;
+         monitor_printf(mon, "\n");
      }
 
-     for (method = method_list; method; method = method->next) {
-         monitor_printf(mon, "%c %s\n", method->value->current ? '*' : ' ',
-                                        method->value->method_name);
-     }
-
-     qapi_free_TimerAlarmMethodList(method_list);
+     qapi_free_OptionRomInfoList(info_list);
  }
 
+It's important to notice that hmp_info_option_roms() calls
+qapi_free_OptionRomInfoList() to free the data returned by
+qmp_query_option_roms().  For user defined types, QAPI will generate a
+qapi_free_QAPI_TYPE_NAME() function, and that's what you have to use to
+free the types you define and qapi_free_QAPI_TYPE_NAMEList() for list
+types (explained in the next section). If the QMP function returns a
+string, then you should g_free() to free it.
+
+Also note that hmp_info_option_roms() performs error handling. That's
+not strictly required when you're sure the QMP function doesn't return
+errors; you could instead pass it &error_abort then.
+
+Another important detail is that HMP's "info" commands go into
+hmp-commands-info.hx, not hmp-commands.hx. The entry for the "info
+option-roms" follows::
+
+     {
+         .name       = "option-roms",
+         .args_type  = "",
+         .params     = "",
+         .help       = "show roms",
+         .cmd        = hmp_info_option_roms,
+     },
+ SRST
+ ``info option-roms``
+   Show the option ROMs.
+ ERST
+
+To test this, run qemu and type "info option-roms" in the user monitor.
+
+
 Writing a debugging aid returning unstructured text
 ---------------------------------------------------
 
 As discussed in section `Modelling data in QAPI`_, it is required that
 commands expecting machine usage be using fine-grained QAPI data types.
 The exception to this rule applies when the command is solely intended
-as a debugging aid and allows for returning unstructured text. This is
-commonly needed for query commands that report aspects of QEMU's
-internal state that are useful to human operators.
+as a debugging aid and allows for returning unstructured text, such as
+a query command that report aspects of QEMU's internal state that are
+useful only to human operators.
 
-In this example we will consider a simplified variant of the HMP
-command ``info roms``. Following the earlier rules, this command will
-need to live under the ``x-`` name prefix, so its QMP implementation
-will be called ``x-query-roms``. It will have no parameters and will
-return a single text string::
-
- { 'struct': 'HumanReadableText',
-   'data': { 'human-readable-text': 'str' } }
+In this example we will consider the existing QMP command
+``x-query-roms`` in qapi/machine.json.  It has no parameters and
+returns a ``HumanReadableText``::
 
+ ##
+ # @x-query-roms:
+ #
+ # Query information on the registered ROMS
+ #
+ # Features:
+ #
+ # @unstable: This command is meant for debugging.
+ #
+ # Returns: registered ROMs
+ #
+ # Since: 6.2
+ ##
  { 'command': 'x-query-roms',
-   'returns': 'HumanReadableText' }
+   'returns': 'HumanReadableText',
+   'features': [ 'unstable' ] }
 
-The ``HumanReadableText`` struct is intended to be used for all
-commands, under the ``x-`` name prefix that are returning unstructured
-text targeted at humans. It should never be used for commands outside
-the ``x-`` name prefix, as those should be using structured QAPI types.
+The ``HumanReadableText`` struct is defined in qapi/common.json as a
+struct with a string member. It is intended to be used for all
+commands that are returning unstructured text targeted at
+humans. These should all have feature 'unstable'.  Note that the
+feature's documentation states why the command is unstable.  We
+commonly use a ``x-`` command name prefix to make lack of stability
+obvious to human users.
 
 Implementing the QMP command
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The QMP implementation will typically involve creating a ``GString``
-object and printing formatted data into it::
+object and printing formatted data into it, like this::
 
  HumanReadableText *qmp_x_query_roms(Error **errp)
  {
@@ -698,6 +595,9 @@ object and printing formatted data into it::
      return human_readable_text_from_str(buf);
  }
 
+The actual implementation emits more information.  You can find it in
+hw/core/loader.c.
+
 
 Implementing the HMP command
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -706,7 +606,7 @@ Now that the QMP command is in place, we can also make it available in
 the human monitor (HMP) as shown in previous examples. The HMP
 implementations will all look fairly similar, as all they need do is
 invoke the QMP command and then print the resulting text or error
-message. Here's the implementation of the "info roms" HMP command::
+message. Here's an implementation of the "info roms" HMP command::
 
  void hmp_info_roms(Monitor *mon, const QDict *qdict)
  {
@@ -746,3 +646,5 @@ field NULL::
         .help         = "show roms",
         .cmd_info_hrt = qmp_x_query_roms,
     },
+
+This is how the actual HMP command is done.
-- 
2.44.0


